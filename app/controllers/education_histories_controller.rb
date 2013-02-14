class EducationHistoriesController < ApplicationController
  # GET /education_histories
  # GET /education_histories.xml
  def index
    #    @education_histories = EducationHistory.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @education_histories }
    end
  end

  # GET /education_histories/1
  # GET /education_histories/1.xml
  def show
    #    @education_history = EducationHistory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @education_history }
    end
  end

  # GET /education_histories/new
  # GET /education_histories/new.xml
  def new
    @user = User.find(params[:user_id])
    @education_history = EducationHistory.new

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @education_history }
    end
  end

  # GET /education_histories/1/edit
  def edit
    @user = User.find(params[:user_id])
    @education_history = EducationHistory.find(params[:id])

    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /education_histories
  # POST /education_histories.xml
  def create
    @education_history = EducationHistory.new(params[:education_history])
    @education_history.user = current_user
    
    respond_to do |format|
      if @education_history.save
        format.html { redirect_to(user_path(current_user.id), :notice => 'Education history was successfully created.') }
        format.js
        format.xml  { render :xml => @education_history, :status => :created, :location => @education_history }
      else
        format.html { redirect_to(new_user_education_history_path)}
        format.xml  { render :xml => @education_history.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /education_histories/1
  # PUT /education_histories/1.xml
  def update
    @education_history = EducationHistory.find(params[:id])
    
    respond_to do |format|
      if @education_history.update_attributes(params[:education_history])
        format.html { redirect_to(user_path(params[:user_id ]), :notice => 'Education history was successfully updated.') }
        format.js
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js
        format.xml  { render :xml => @education_history.errors, :status => :unprocessable_entity }
      end
    end
  end
  def search 
    @tags = ActsAsTaggableOn::Tag.find(:all,
      :conditions=>["name like ?",
        "%#{params[:q]}%"])
  respond_to do |format|
    format.html
    format.json { render :json => @tags.map(&:attributes) }
  end
  end
  # DELETE /education_histories/1
  # DELETE /education_histories/1.xml
  def destroy
        @education_history = EducationHistory.find(params[:id])
        @education_history.destroy

    respond_to do |format|
      format.html { redirect_to(user_path(params[:user_id ])) }
      format.js
      format.xml  { head :ok }
    end
  end
end
