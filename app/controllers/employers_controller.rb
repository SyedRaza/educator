class EmployersController < ApplicationController
  # GET /employers
  # GET /employers.xml

  # GET /employers/1/edit
  def edit
    @user = User.find(params[:user_id])
    @employer = Employer.find(params[:id])
    
    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @employer }
    end
  end

 

  # PUT /employers/1
  # PUT /employers/1.xml
  def update
    @employer = Employer.find(params[:id])

    respond_to do |format|
      if @employer.update_attributes(params[:employer])
        format.html { redirect_to(@employer, :notice => 'Employer was successfully updated.') }
        format.js
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @employer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /employers/1
  # DELETE /employers/1.xml
  def destroy
    @employment_histories = EmploymentHistory.search({:user_id_eq=>params[:user_id],:employer_id_eq=>params[:id]}).all
    @employment_histories.each do |em|
      em.destroy
    end

    @employment_histories = EmploymentHistory.search({:employer_id_eq=>params[:id]}).all
    if @employment_histories.count == 0
      @employer = Employer.find(params[:id])
      @employer.destroy
    end

    respond_to do |format|
      format.js
      format.xml  { head :ok }
    end
  end
end
