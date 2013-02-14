class ArchivesController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
  def all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
  def showcase
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def rules
    respond_to do |format|
      format.html {render :layout => false}
    end  
  end

  def new
    respond_to do |format|
      format.js
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end

end
