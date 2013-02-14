class SettingsController < ApplicationController
  
  def account
     
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
    end
  end
  def blocklist
    @list = [
      {
        :image =>'user4.jpg',
        :first_name => 'Tariq',
        :last_name => 'Tariq',
      },
      {
        :image =>'user1.jpg',
        :first_name => 'Ayaz',
        :last_name  => 'Khan',
              
      },
      {
        :image =>'user3.jpg',
        :first_name => 'Kamaal',
        :last_name  => 'Ejaz',
              
      },
      {
        :image =>'user2.jpg',
        :first_name => 'Raza',
        :last_name  => 'Khalid',
              
      },
      {
        :image =>'user5.jpg',
        :first_name => 'Nazar',
        :last_name  => 'Hussain',
              
      }
    ]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
    end
  end
  def privacy
    user = User.find_by_id( current_user.id )
    if params.has_key?(:discussion_board)
      discussion_board( params[:discussion_board], user )
    elsif params.has_key?( :profile )
      profile( params[:profile], user )
    elsif params.has_key?( :messages )
      messages( params[:messages], user )
    elsif params.has_key?( :requests )
      requests( params[:requests], user )
    elsif params.has_key?( :contacts )
      contacts( params[:contacts], user )
    elsif params.has_key?( :search )
      search( params[:search], user )
    end

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @messages }
    end
  end
  def account_setting
    @message = ''
    @type = ''
    user = User.find_by_id( current_user.id )
    if params.has_key?(:pass_change)
      if current_user.valid_password?( params[:pass_change][:old_password].to_s )
        user = User.find_by_id( current_user.id )
        new_password = params[:pass_change][:new_password].to_s
        if user.update_attributes(:password=>new_password)
          
        end
      else
        @message = "Invalid password"
      end
    elsif params.has_key?( :new_email )
      current_user.emails.create( :email=>params[:new_email][:new_email] )
    elsif params.has_key?( :set_email )
      current_user.emails.update_all(:primary => false)
      email = current_user.emails.
        find_by_id(params[:set_email][:set_default])
      email.update_attributes( :primary=>true )
      
      user.update_attributes(:email=>email.email)
    elsif params.has_key?( :secret )
      user.update_attributes( :secret_question_id => params[:secret][:secret_question],
        :secret_answer=>params[:secret][:secret_answer] )
    elsif params.has_key?(:deactivate_account)
      user.update_attributes(:deactive=>true,
        :deactivate_reason=>params[:deactivate_account][:reasons_text],
        :deactivate_account_id=>params[:deactivate_account][:reasons],
        :deactivate_account_date=>DateTime.now)
    end
    respond_to do |format|
      format.html{ redirect_to( account_user_settings_path( current_user ) ) }
      format.js 
    end

  end
  private 
  
  def discussion_board board, user 
    user.update_attributes value_maping board
  end

  def profile board, user
    user.update_attributes value_maping board
  end

  def messages board, user
    user.update_attributes value_maping board
  end

  def requests board, user
    user.update_attributes value_maping board
  end

  def contacts board, user
    user.update_attributes value_maping board
  end

  def search board, user
    user.update_attributes value_maping board
  end

  def value_maping value
    new_value = {}
    value.each {|k, v| new_value[k] = 2**( v.to_i - 1)  }
    value.replace new_value
    value
  end

end
