class RequestsController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    @hide_control= nil
    if params[:type]=='Request' || params.has_key?(:type)==false
      @requests = Request.paginate :page=> params[:page],
        :conditions=>["request_id = ? and confirm = ? and block = ? ",
        current_user.id, false, false],
        :order=>' created_at DESC '
    elsif params[:type]=='Invitation'
      @hide_control = true
      @requests = Request.paginate :page=> params[:page],
        :conditions=>["user_id = ? and request_id is ? and confirm = ? and block = ?",
        current_user.id, nil,false, false],
        :order=>' created_at DESC '
    elsif params[:type]=='Outgoing'
      @hide_control = true
      @requests = Request.paginate :page=> params[:page],
        :conditions=>["user_id = ? and confirm = ? and block = ?",
        current_user.id, false, false],
        :order=>' created_at DESC '
    end

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @users }
    end
  end
  def request_action    
    if params.has_key?(:commit)
      update_key = params[:commit].downcase
    end
    Request.update_all({ update_key.to_sym=>true,
        :contact_type_id=>params[:request][:contact_type_id] },
      { :id=> params[:request][:id] })
    if params[:commit]=='Confirm'
      @request = Request.find_by_id(params[:request][:id])
      add_contact( @request.request_id, @request.user_id, params[:request][:contact_type_id] )
      add_contact( @request.user_id, @request.request_id )
    end
    @requests = Request.paginate :page=> params[:page],
      :conditions=>["request_id = ? and confirm = ? and block = ? ",
      current_user.id, false, false],
      :order=>' created_at DESC '
    respond_to do |format|
      format.js
    end
  end
  
  def new
    @user = User.find(params[:user_id])
    @request = Request.new

    respond_to do |format|
      format.js
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
    
  end

  def create
    @request = Request.new( params[:request] )
    @request.user_id = current_user.id
    @request.save
    
    respond_to do |format|
      format.html
      format.js
    end

  end
  
  private
  
  def add_contact( companion_id, user_id, contact_type_id = nil )
    contact = Contact.new
    contact.companion_id = companion_id
    contact.user_id= user_id
    contact.save
    unless contact_type_id.nil?
      contact_type_contacts = ContactTypesContact.new
      contact_type_contacts.contact_id = contact.id
      contact_type_contacts.contact_type_id = contact_type_id
      contact_type_contacts.save
    end
  end
  
end