class EmploymentHistoriesController < ApplicationController
  # GET /employment_histories
  # GET /employment_histories.xml
  def index
    @employment_histories = EmploymentHistory.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @employment_histories }
    end
  end

  # GET /employment_histories/1
  # GET /employment_histories/1.xml
  def show
    @employment_history = EmploymentHistory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @employment_history }
    end
  end
  def add
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /employment_histories/new
  # GET /employment_histories/new.xml
  def new
    @user = User.find(params[:user_id])
    @employment_history = EmploymentHistory.new
    @show_employer = params[:show_employer].nil? ? true  : false
    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @employment_history }
    end
  end
  
  def search
    unless params[:type]=="my_interest"
      @tags = ActsAsTaggableOn::Tag.find(:all,
        :conditions=>["tags.name like ? and taggings.context=?","%#{params[:q]}%","#{params[:type]}"],
        :joins => [:taggings], :group=>:name )
    else
      @tags = ActsAsTaggableOn::Tag.find(:all,
        :conditions=>["name like ?","%#{params[:q]}%"])
    end
    respond_to do |format|
      format.html
      format.json { render :json => @tags.map(&:attributes) }
    end

  end

  # GET /employment_histories/1/edit
  def edit
    @user = User.find(params[:user_id])
    @employment_history = EmploymentHistory.find(params[:id])
    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @employment_history }
    end
  end

  # POST /employment_histories
  # POST /employment_histories.xml
  def create
    employment_history = params[:employment_history]
    employer_id = employment_history[:employer_id]
    if employer_id.kind_of? String
      em = Employer.search(:title_like=>employer_id).all
      if em.count > 0
        em = em.first
        employment_history[:employer_id] = em.id
        employment_history[:user_id] = params[:user_id]
      else
        em = Employer.new
        em.title = employer_id
        em.save
        employment_history[:employer_id] = em.id
        employment_history[:user_id] = params[:user_id]
      end
    end
    employment_history.delete :employer
    @employment_history = EmploymentHistory.new(employment_history)

    respond_to do |format|
      if @employment_history.save
        format.html { redirect_to(user_path(params[:user_id]), :notice => 'Employment history was successfully created.') }
        format.js
        format.xml  { render :xml => @employment_history, :status => :created, :location => @employment_history }
      else        
        format.html { render :action => "new" }
        format.xml  { render :xml => @employment_history.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /employment_histories/1
  # PUT /employment_histories/1.xml
  def update
    
    @employment_history = EmploymentHistory.find(params[:id])
    employment_history = params[:employment_history]
    employment_history.delete :employer

    respond_to do |format|
      if @employment_history.update_attributes(employment_history)
        format.html { redirect_to(user_path(current_user.id), :notice => 'Employment history was successfully updated.') }
        format.js
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @employment_history.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /employment_histories/1
  # DELETE /employment_histories/1.xml
  def destroy
    @employment_history = EmploymentHistory.find(params[:id])
    @employment_history.destroy

    respond_to do |format|
      format.html { redirect_to(user_path(params[:user_id])) }
      format.js
      format.xml  { head :ok }
    end
  end
  def examples
    respond_to do |format|
      format.html {render :layout => false}
    end
  end
end
