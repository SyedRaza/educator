class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable

  after_save :insert_nick_name#, :set_primary_email
  after_create :set_primary_email
  def set_primary_email
    self.emails.create(:email=>self.email, :primary=>true)
  end

 
  def insert_nick_name    
    self.update_attribute(:nick_name, "#{self.first_name.gsub(' ','_')}_#{self.last_name.gsub(' ','_')}_#{self.id}".downcase ) if self.nick_name.nil?
  end
  
  message_box
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,
    :first_name, :last_name, :remember_me, :nick_name, :gender,
    :date_of_birth, :address_1, :address_2, :zip_code, :city, :state,:country,
    :website, :about_me, :contact_no, :display_picture, :facebook_name, :skype_name,
    :linkedin_name, :secret_question_id, :secret_answer,
    :deactivate_account_id, :deactivate_reason, :deactive, :deactivate_account_date,
    :comment_dashboard_visibility, :post_dashboard_visibility, :name_visibility,
    :about_me_visibility, :date_of_birth_visibility, :date_of_birth_year_visibility,
    :contact_information_visibility, :contact_no_visibility, :email_visibility,
    :website_visibility, :education_history_visibility, :employment_history_visibility,
    :messages_visibility, :request_visibility, :contacts_list_visibility,
    :search_visibility






  
  def set_picture_respect_to_gender
    self.gender? ? '/images/male.jpg' : '/images/female.jpg'
  end
  
  has_attached_file :display_picture, :styles => { :medium => "150x150>", :thumb => "100x100>", :small => "50x50>" },
    :url => "/system/user/:id/:attachment/:style/:basename.:extension",
    :path => ":rails_root/public/system/user/:id/:attachment/:style/:basename.:extension",
    :default_url => :set_picture_respect_to_gender

  has_many :emails, :dependent=>:destroy
  has_many :education_histories, :dependent => :destroy
  has_many :employment_histories
  has_many :employers , :through=>:employment_histories
  has_many :contacts, :dependent => :destroy
  has_many :companions, :through=>:contacts,
    :foreign_key => :companion_id, :class_name=>'User'
  has_many :contact_types
  has_many :requests, :dependent => :destroy
  has_many :sent_requests, :through=>:requests,
    :foreign_key=> :request_id, :class_name=>'User'
  belongs_to :secret_question
  belongs_to :deactivate_account
  def tag_list(context)
    list = []
    u = self
    if context == 'my_interest'
      u.employment_histories.each {
        |em| list |= em.my_interest_list
      }
      u.education_histories.each {
        |ed| list |= ed.my_interest_list
      }
    elsif context == 'grade'
      u.employment_histories.each {
        |em| list |= em.grade_list
      }
    elsif context == 'subject'
      u.employment_histories.each {
        |emh| list |= emh.subject_list
      }
    end
    return list
  end


  validates :nick_name, :uniqueness=>true
  validates :first_name, :presence=>true
  validates :last_name, :presence=>true
  validates :nick_name, :length=>{:maximum => 25}
  validates :address_1, :length=>{:maximum => 50}
  validates :address_2, :length=>{:maximum => 50}
  

  def user_age
    d = (Date.today - self.date_of_birth.to_date).to_i
    "#{(d/365).round} years"
  end

  def is_friend?(user)
    self.companions.index(user) != nil
  end

  def is_requested?(user)
    !self.requests.search(:confirm_eq=>false,:block_eq=>false,:request_id_eq=>user.id).all.empty?
  end
  
  def show_country
    if self.country.nil?
      "-"
    elsif self.country ==""
      "-"
    else
      "#{Carmen::country_name(self.country)}"
    end
  end

  def user_description
    str = "<div class='width-100-percent check-box-cell left space-inner-5 text-align-center'>"
    str << "<div >"
    if display_picture.file?
      str << "<img src='#{display_picture.url()}' class='list-pic' />"
    else
      if gender == true
        str << "<img src='/images/male.jpg' class='list-pic' />"
      else
        str << "<img src='/images/female.jpg' class='list-pic' />"
      end
    end
    str << "</div>"
    str << "<div >"
    str <<  "<span> #{first_name} #{last_name}</span>"
    str << "</div>"
    str << "</div>"
    str.html_safe
  end
  
end