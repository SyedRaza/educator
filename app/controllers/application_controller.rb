class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :initialize_data, :mailer_set_url_options, :browser_detection, :authenticate_user!
  layout :layout_by_resource

  helper_method :get_parent
  
  def initialize_data
    if (current_user.respond_to? :time_zone)
      Time.zone         = current_user.time_zone || 'Central Time (US & Canada)'
      Time.zone_default = current_user.time_zone || 'Central Time (US & Canada)'
    else
      Time.zone = 'Central Time (US & Canada)'
    end
  end

  def get_parent( child )
    until Message.find_by_id(child).reply_of.nil?
      child = Message.find_by_id(child).reply_of
    end
    child
  end
  def after_sign_in_path_for(resource_or_scope)
    if current_user.sign_in_count == 1
      session[:confirm] = 'true'
      '/users/sign_out'
    else
      '/'
    end
  end
  
  def after_sign_out_path_for(resource_or_scope)
     reset_session;
    '/users/sign_in'
  end
  def mailer_set_url_options
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end

  def layout_by_resource
    if devise_controller?
      "login"
    else
      "application"
    end
  end
  
 
  def browser_detection
    result  = request.env['HTTP_USER_AGENT']
    browser_compatible = nil
    if result =~ /Safari/
      unless result =~ /Chrome/
        version = result.split('Version/')[1].split(' ').first.split('.').first
        browser_compatible = 'Application is not functional for <strong>Safari</strong> version\'s <strong>'+version+'</strong> Please update your browser' if version.to_i < 5
      else
        version = result.split('Chrome/')[1].split(' ').first.split('.').first
        browser_compatible = 'Application is not functional for <strong>Chrome</strong> version\'s <strong'+version+'</strong> Please update your browser' if version.to_i < 10
      end
    elsif result =~ /Firefox/
      version = result.split('Firefox/')[1].split('.').first
      browser_compatible = 'Application is not functional for <strong>Firefox</strong> version\'s <strong>'+version+'</strong> Please update your browser' if version.to_i < 4
    elsif result =~ /Opera/
      version = result.split('Version/')[1].split('.').first
      browser_compatible = 'Application is not functional for <strong>Opera</strong> version\'s <strong>'+version+'</strong> Please update your browser' if version.to_i < 11
    elsif result =~ /MSIE/
      version = result.split('MSIE')[1].split(' ').first
      browser_compatible = 'Application is not functional for <strong>Internet Explorer</strong> version\'s <strong>'+version+'</strong> Please update your browser' if version.to_i < 9
    end
    unless browser_compatible.nil?
      @browser_message = browser_compatible.html_safe
    else
      @browser_message = nil
    end
  end

  def search_user(list)
  tag_id_list = ActsAsTaggableOn::Tag.search({:name_in=>list}).all.map{
    |m| m.id
  }
  education_id_list = ActsAsTaggableOn::Tagging.search({:tag_id_in=>tag_id_list,:taggable_type_eq =>'EducationHistory'}).all.map{ |m| m.taggable_id}
  user_id_list1 = EmploymentHistory.search({:id_in=>education_id_list}).all.map{ |m| m.user_id}
  employment_id_list = ActsAsTaggableOn::Tagging.search({:tag_id_in=>tag_id_list,:taggable_type_eq =>'EmploymentHistory'}).all.map{ |m| m.taggable_id}
  user_id_list2 = EmploymentHistory.search({:id_in=>employment_id_list}).all.map{ |m| m.user_id}
  #  user_id_list = Employer.search({:id_in=>employer_id_list}).all.map{ |m| m.user_id }
  user_id_list = user_id_list1 | user_id_list2
  user_id_list = user_id_list - [nil]
  return user_id_list
end
  #  @browser_message = self.browser_detection.html_safe
end
