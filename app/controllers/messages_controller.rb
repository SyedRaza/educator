class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.xml
  def index
    if params.has_key?(:type)
      if params[:type]=='incoming' || params[:type]=='Unread'
        @messages = current_user.new_messages
      elsif params[:type]=='Sent'
        @messages = current_user.outbox
      elsif params[:type]=='Read'
        @messages = current_user.inbox :conditions=>'messages.read = 1'
      
      elsif params[:type]=='All'
        @messages = current_user.inbox :order=> 'messages.read ASC'

      elsif params[:type]=='None'
        @messages= []
        @users=[]
      end
    else
      @messages = current_user.inbox :order=> 'messages.read ASC'

      @users = current_user.companions.search(:first_name_like=>params[:q]).
        all.map { |user| {:id=>user.id ,:name=> user.first_name} }
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
      format.js
      format.xml  { render :xml => @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    @message = current_user.read_message params[:id]
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end

  def replies
    message = Message.find_by_id( params[:id] )
    if message.sender_id == current_user.id
      message = Message.find_by_id( message.reply_of )
    end

    current_user.reply_message( message, "#{message.subject}",
      params[:replies][:message_reply], params[:replies][:upload] )
    respond_to do |format|
      format.html{ redirect_to user_message_path(current_user.id, get_parent(params[:id]))}
      format.js
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @user = User.find(current_user.id)
    @message = Message.new
    if current_user.id != params[:user_id].to_i
      recipent = User.find_by_id( params[:user_id] )
      @reciever = [{ :id=>recipent.id, :name=>recipent.first_name }]
    end
    5.times{ @message.uploads.build }
    respond_to do |format|
      format.js
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.xml
  def create
    recievers = params[:message][:receiver].split(',')
    recievers.each do |r|
      current_user.send_message( User.find( r ), params[:message][:subject],
        params[:message][:body], params[:message][:uploads_attributes] )
    end
    respond_to do |format|
      format.html { redirect_to( user_messages_path, :notice => 'Message was successfully created.') }
      format.js
      format.xml  { render :xml => @message, :status => :created, :location => @message }
    end
  end

  # PUT /messages/1
  # PUT /messages/1.xml
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to(@message, :notice => 'Message was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  def delete_messages
    unless params[:message_list].nil?
      params[:message_list].each do |m|
        current_user.delete_message( m )
      end
    end
    redirect_to( user_messages_path )
  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    current_user.delete_message( params[:id] )

    respond_to do |format|
      format.html { redirect_to(user_messages_path) }
      format.xml  { head :ok }
    end
  end
  def message_search
    ids=[]
    current_user.companions.
      search(:first_name_like=>params[:message_search][:search]).
      each{|companion| ids<<companion.id}

    @messages = Message.find(:all,
      :conditions=>[" `messages`.`receiver_id` = ? AND
                      `messages`.`reply_of` IS NULL
                      AND (`messages`.`subject` LIKE ? OR
                      `messages`.`sender_id` IN (?)) AND (
                      `messages`.`trashed_by_receiver` != ?)",
                      current_user.id,"%#{params[:message_search][:search]}%",
                      ids, current_user.id ],
                    :order=>'messages.read ASC')
    respond_to do |format|
      format.html
      format.js
      format.xml
    end
  end
end
