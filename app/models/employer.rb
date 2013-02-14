class Employer < ActiveRecord::Base

  has_many  :user, :through =>:employment_histories
  has_many :employment_histories, :inverse_of =>:employer
  accepts_nested_attributes_for  :employment_histories
  validates :title, :presence=>true

end
