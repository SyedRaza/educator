class EmploymentHistory < ActiveRecord::Base

  belongs_to :employer, :inverse_of=> :employment_histories
  acts_as_taggable_on :my_interest, :subjects, :grades
  belongs_to :user
  def title
    employer.title
  end
  def month_year
    if self.start_date.nil?
      "-"
    elsif self.end_date.nil?
      "#{Date::ABBR_MONTHNAMES[self.start_date.month]},#{self.start_date.year} - Present"
    else
      "#{Date::ABBR_MONTHNAMES[self.start_date.month]},#{self.start_date.year} - #{Date::ABBR_MONTHNAMES[self.end_date.month]},#{self.end_date.year}"
    end  
  end
  #  validates :position, :presence=>true
  #  validates :grade, :presence=>true
  #  validates :start_date, :presence=>true
  #  validates :end_date, :presence=>true
  #  def title
  #    employer.title
  #  end
end
