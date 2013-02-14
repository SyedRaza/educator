class Request < ActiveRecord::Base
  belongs_to  :contact_type
  belongs_to :user
  belongs_to :sent_request, :class_name=>'User', :foreign_key => :request_id
  cattr_reader :per_page
  @@per_page = 10
  def friend_name
    unless self.request_id.nil?
      "<a href='/users/#{self.user_id}'>#{User.find_by_id(self.user_id).first_name}</a>".html_safe
    else
      self.email
    end

  end
end
