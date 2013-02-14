class Contact < ActiveRecord::Base
  belongs_to :user
  belongs_to :companion, :class_name=>'User', :foreign_key => :companion_id
#  attr_accessible :title, :group_tokens
  has_many :contact_types_contacts
  has_many :contact_types, :through=>:contact_types_contacts
#  attr_reader :group_tokens
  accepts_nested_attributes_for :contact_types
  cattr_reader :per_page
  @@per_page = 10

#  def group_tokens=(ids)
#    self.contact_type_ids = ids.split(",")
#  end
  
end
