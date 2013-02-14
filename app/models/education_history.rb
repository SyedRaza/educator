class EducationHistory < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable_on :my_interest
#  validates :institute_name, :presence=>true
#  validates :type_of_degree, :presence=>true
#  validates :degree_conferred, :presence=>true
#  validates :from, :presence=>true
#  validates :to, :presence=>true

end
