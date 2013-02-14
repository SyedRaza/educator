class DashboardController < ApplicationController
  # GET /users
  # GET /users.xml
  def home
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

end
