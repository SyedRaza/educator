class SecretQuestion < ActiveRecord::Base
  has_many :users
  def to_s
    self.secret_question
  end
end
