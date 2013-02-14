class ContactType < ActiveRecord::Base
  has_many :contact_types_contacts
  has_many :contacts, :through => :contact_types_contacts
  belongs_to :user
  has_many :requests
  scope :default_groups, :conditions => { :default_groups => true }

  def to_s
    self.title
  end

end
