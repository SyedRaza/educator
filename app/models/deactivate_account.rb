class DeactivateAccount < ActiveRecord::Base
  has_many :users
  def to_s
    self.reasons
  end
end
