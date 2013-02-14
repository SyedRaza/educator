class ContactsController < ApplicationController
  require 'csv'
  require Rails.root.join('app','mailers','send_mailer.rb')
  require 'rubygems'
  require 'contacts_cn'
  helper_method :search_user
  # GET /users
  # GET /users.xml
  def index

    @list= current_user.companions.paginate :page=>params[:page],
      :order=>'first_name,last_name ASC'

    unless params[:search_contacts].nil?
      @list= current_user.companions.paginate :page=>params[:page],
        :conditions=>['first_name like ? or last_name like ?',"%#{params[:search_contacts][:name]}%","%#{params[:search_contacts][:name]}%"],
        :order=>'first_name,last_name ASC '
    end
    unless params[:show_detail].nil?
      @companion = User.find_by_id(params[:comp_id])
    end
    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @users }
    end

  end

  # ------------------------------method for importing contacts from csv, gmail, yahoo and hotmail---------------------
  
  def import

    unless params[:import_form].nil?
      @already_member_list = []
      @not_member_list = []
      @type_of_import = params[:import_form][:type_of_import]

      @email = params[:import_form][:email]
      @pass = params[:import_form][:password]

      begin
        if @type_of_import.eql? 'hotmail'
          @contacts = Contacts::Hotmail.new(@email,@pass).contacts.map {|contact| contact[1].split('&amp')[0].gsub('%40','@')}
        elsif @type_of_import.eql? 'yahoo'
          @contacts = Contacts::Yahoo.new(@email,@pass).contacts
        elsif @type_of_import.eql? 'gmail'
          @contacts = Contacts::Gmail.new(@email,@pass).contacts
        end

      rescue
        @error = 'Username or password are incorrect'       
      end
      
      unless @contacts.nil?
        @contacts.each do |contact|
          if @type_of_import.eql? 'hotmail'
            contact_email = contact
          else
            contact_email = contact[1]
          end
          @search= User.search(:email_eq => contact_email)
          if @search.count == 0
            @not_member_list << {:email => contact_email}
          else
            @already_member_list << @search.first
          end
        end
      end
    end

    if params[:commit]=="Send Friend Request"
      params[:already_member].each do |am|
        @request = Request.new
        @request.user_id = current_user.id
        @request.request_id = am
        @request.save
      end
    end

    unless params[:not_member_list].nil?
      @selected_users = params[:not_member_list]
  
      unless @selected_users.nil?
        @selected_users.each do |user|
          user_info = user.split('-')
          @name= "#{current_user.first_name} #{current_user.last_name}"
          SendMailer.registration_confirmation(user_info[0], user_info[1],@name, current_user.id).deliver
          @request= Request.new
          @request.email= user_info[1]
          @request.user_id=current_user.id
          @request.save
        end
      end
    end

    unless params[:import].nil?

      @already_member_list = []
      @not_member_list = []
      CSV.open(params[:import][:upload_csv].tempfile, 'r', {:headers => true}).each do |row|
        unless row[14].nil?
          @search = User.search(:email_eq =>row[14]).all.first
          if @search.nil?
            @not_member_list << {:first_name => row[0], :last_name=> row[1], :email => row[14]}
          else            
            unless current_user.is_friend? @search or current_user.is_requested? @search
              @already_member_list << @search
            end
          end
        end
      end
    end
    

    respond_to do |format|
      format.html
      format.js
    end

  end

  # -----------------------------method for inviting friends-------------------------------------------

  def invite

    unless params[:invite].nil?
      @to_email = params[:invite][:enter_email]
      @email_body = params[:invite][:enter_message]
      @user=current_user
      @to_email.split(',').each { |to| SendMailer.invitation_mail(to, @user,@email_body).deliver}    
    end

    respond_to do |format|
      format.html
      format.js
    end

  end

  # --------------------------method for finding friends in eduactorsplanet--------------------------
  
  def find_friends
    
    @grade_list = current_user.tag_list('grade')
    @subject_list = current_user.tag_list('subject')
    @my_interest_list = current_user.tag_list('my_interest')


    if session[:grade_list].nil?
      session[:grade_list] = []
    end
    if session[:subject_list].nil?
      session[:subject_list] = []
    end
    if session[:my_interest_list].nil?
      session[:my_interest_list] = []
    end

    unless params[:filter].nil?
      filter = params[:filter]
      session[:grade_list] << filter[:grade_box][:grade] unless filter[:grade_box][:grade].nil?
      session[:subject_list] << filter[:subject_box][:subject] unless filter[:subject_box][:subject].nil?
      session[:my_interest_list] << filter[:my_interest_box][:my_interest] unless filter[:my_interest_box][:my_interest].nil?
    end
 
    @grade_list |= session[:grade_list] unless session[:grade_list].empty?
    @subject_list |= session[:subject_list] unless session[:subject_list].empty?
    @my_interest_list |= session[:my_interest_list] unless session[:my_interest_list].empty?

    @list_all = @grade_list |@subject_list | @my_interest_list
    @users_all= search_user(@list_all)
    @members = User.search({:id_in=>@users_all}).all
    @members = @members - [current_user]
    current_user.companions.each do |c|
      @members = @members - [c]
    end
    unless params[:filter].nil?
      
      filter = params[:filter]
      grades = filter[:grade_box][:grade_list] - [nil, ""]
      grades << filter[:grade_box][:grade] unless filter[:grade_box][:grade].empty?

      subjects = filter[:subject_box][:subject_list] - [nil, ""]
      subjects << filter[:subject_box][:subject] unless filter[:subject_box][:subject].empty?

      interests = filter[:my_interest_box][:my_interest_list] - [nil, ""]
      interests << filter[:my_interest_box][:my_interest] unless filter[:my_interest_box][:my_interest].empty?
      
      name ||= filter[:name][:search_by_name]

      users = []


      unless grades.empty?
        gradess = array_to_string(grades)
        users << User.find_by_sql("SELECT
users.* ,
COUNT(*) AS COUNT
FROM users
    LEFT JOIN employment_histories ON  users.id = employment_histories.user_id
    LEFT JOIN taggings ON taggings.taggable_id = employment_histories.id
    LEFT JOIN tags ON tags.id = taggings.tag_id AND taggings.context = 'grades'
WHERE #{gradess}
GROUP BY users.id
HAVING COUNT = #{grades.count}")
      end

      unless subjects.empty?
        subjectss = array_to_string(subjects)
        users << User.find_by_sql("SELECT
users.* ,
COUNT(*) AS COUNT
FROM users
    LEFT JOIN employment_histories ON  users.id = employment_histories.user_id
    LEFT JOIN taggings ON taggings.taggable_id = employment_histories.id
    LEFT JOIN tags ON tags.id = taggings.tag_id AND taggings.context = 'subjects'
WHERE #{subjectss}
GROUP BY users.id
HAVING COUNT = #{subjects.count}")
      end

      unless interests.empty?
        interestss = array_to_string(interests)
        users << User.find_by_sql("SELECT
users.* ,
COUNT(*) AS COUNT
FROM users
    LEFT JOIN employment_histories ON  users.id = employment_histories.user_id
    LEFT JOIN taggings ON taggings.taggable_id = employment_histories.id AND taggings.taggable_type = 'EmploymentHistory'
    LEFT JOIN tags ON tags.id = taggings.tag_id AND taggings.context = 'my_interest'
WHERE #{interestss}
GROUP BY users.id
HAVING COUNT = #{interests.count}")
        users << User.find_by_sql("SELECT
users.* ,
COUNT(*) AS COUNT
FROM users
    LEFT JOIN education_histories ON  users.id = education_histories.user_id
    LEFT JOIN taggings ON taggings.taggable_id = education_histories.id AND taggings.taggable_type = 'EducationHistory'
    LEFT JOIN tags ON tags.id = taggings.tag_id AND taggings.context = 'my_interest'
WHERE #{interestss}
GROUP BY users.id
HAVING COUNT = #{interests.count}")
      end

      users << User.search({:first_name_or_last_name_contains=>name}).relation.select("DISTINCT users.*").all unless name.blank?
      users = users.map! { |item| item unless item.empty? }
      users = users - [nil]
      users = users - [current_user]
      @users = users.first
      users.each do |u|
        @users = @users & u
      end   
    end
   

    respond_to do |format|
      format.html
      format.js
    end
  end

  # ------------------------method for to convert tags array into string for search--------------------

  def array_to_string(grades)
    first_element = grades.first
    grades = grades[1..grades.length]
    query = "tags.name='#{first_element}'"
    grades.each do |e|
      query << " OR tags.name='#{e}'"
    end
    return query
  end

  # ---------------------contact grouping method----------------------------------

  def group

    unless params[:group].nil?
      group = params[:group]
      @contact_type = ContactType.new
      @contact_type.title = group[:group_name]
      @contact_type.user_id = params[:user_id]
      @contact_type.default_groups = false
      @contact_type.save
      contacts = group[:contacts]-[""]
      unless contacts.empty?
        @contacts = Contact.search({:user_id_eq=>params[:user_id],:companion_id_in=>contacts}).all.map {|m| m.id}
        @contacts.each do |c|
          @contact_types_contacts = ContactTypesContact.new
          @contact_types_contacts.contact_type_id = @contact_type.id
          @contact_types_contacts.contact_id = c
          @contact_types_contacts.save
        end
      end
    end
    unless params[:group_name].nil?
      @group = ContactType.find_by_title(params[:group_name])
      @user_list = []
      
      @contacts = ContactType.search(:title_eq=>params[:group_name]).all.first.contacts
      @contacts.each do |c|
        @user_list << c.companion
      end
      @user_list = @user_list.paginate :page=>params[:page],
        :order=>'first_name,last_name ASC'
    end

    unless params[:friend_id].nil?
      @contact = Contact.search({:user_id_eq=>params[:user_id],:companion_id_eq=>params[:friend_id]}).all.map { |m| m.id}
      @contact_type = ContactType.search(:title_eq=>params[:group_title]).all.map {|m| m.id}
      @contact_contact_type = ContactTypesContact.search(:contact_id_in=>@contact,:contact_type_id_in=>@contact_type).all
      @contact_contact_type.first.destroy
    end

    unless params[:friendd_id].nil?
      @contact = Contact.search({:user_id_eq=>params[:user_id],:companion_id_eq=>params[:friendd_id]}).all.first
      @contact_type = ContactType.search(:id_eq=>params[:group_id]).all.map {|m| m.id}
      @group_ids = @contact.contact_types.map { |m| m.id }
      if @group_ids.include?(@contact_type.first)
      else
        @contact_contact_type = ContactTypesContact.new
        @contact_contact_type.contact_type_id = @contact_type.first
        @contact_contact_type.contact_id = @contact.id
        @contact_contact_type.save
        @group = ContactType.search(:id_eq=>params[:group_id]).all.first
      end
    end
    unless params[:companions].nil?
      params[:companions].each do |c|
        @contact = Contact.search(:user_id_eq=>current_user.id,:companion_id_eq=>c).all.first
        @group_ids = @contact.contact_types.map { |m| m.id }
        if @group_ids.include?(params[:grouptype][:group_type_id].to_i)        
        else
          @contact_type_contact = ContactTypesContact.new
          @contact_type_contact.contact_type_id = params[:grouptype][:group_type_id]
          @contact_type_contact.contact_id = @contact.id
          @contact_type_contact.save
        end
      end
      @notice = "contacts Successfully assigned to the selected group"
    end
    unless params[:companion_id].nil?
      @group = ContactType.find_by_id(params[:group_id])
      @contact = current_user.contacts.find_by_companion_id(params[:companion_id])
      @contact_types_contact = ContactTypesContact.find_by_contact_id_and_contact_type_id(@contact.id,params[:group_id])
      @contact_types_contact.destroy

      @group_user_list = []

      @contacts = ContactType.search(:id_eq=>params[:group_id]).all.first.contacts
      @contacts.each do |c|
        @group_user_list << c.companion
      end
      @group_user_list = @group_user_list.paginate :page=>params[:page],
        :order=>'first_name,last_name ASC'
    end
    unless params[:edit].nil?
      @editable_group = ContactType.find_by_id(params[:group_id])
    end
    unless params[:group_edit].nil?
      @edit_form = true
      @group = ContactType.search(:id_eq=>params[:group_edit][:group_id],:default_groups_eq=>false).all.first
      if @group.nil?
      else
        @group.update_attributes(:title=>params[:group_edit][:title])
      end
    end
    unless params[:delete].nil?
      @contact_type = ContactType.find_by_id_and_default_groups(params[:group_id],false)
      if @contact_type.nil?
      else
        @contact_types_contacts = @contact_type.contact_types_contacts
        @contact_types_contacts.each do |c|
          c.destroy
        end
        @contact_type.destroy
      end
    end

    respond_to do |format|
      format.html # group.html.erb
      format.json 
      format.js
    end
  end

  # ---------------------------------contacts deleting method-----------------------------------

  def destroy
    contact_delete(params[:user_id],params[:id])
    contact_delete(params[:id],params[:user_id])
    @notice = "contact successfully removed"
    @list= current_user.companions.paginate :page=>params[:page],
      :order=>'first_name,last_name ASC'
    respond_to do |format|
      format.js
    end
  end

  protected
  # ----------------------------------contact-delete-protected method----------------------------------

  def contact_delete(user,comp)
    @contact = Contact.search({:user_id_eq=>user,:companion_id_eq=>comp}).all
    @contact_contact_type = ContactTypesContact.search(:contact_id_in=>@contact.map {|m| m.id}).all
    @contact.first.destroy
    @contact_contact_type.each do |c|
      c.destroy
    end
  end
  
end