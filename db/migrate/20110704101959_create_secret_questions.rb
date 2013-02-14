class CreateSecretQuestions < ActiveRecord::Migration
  def self.up
    create_table :secret_questions do |t|
      t.string :secret_question

      t.timestamps
    end
    SecretQuestion.create(:secret_question=>'What was your childhood nickname?')
    SecretQuestion.create(:secret_question=>'In what city did you meet your spouse/significant other?')
    SecretQuestion.create(:secret_question=>'What is the name of your favorite childhood friend?')
    SecretQuestion.create(:secret_question=>'What street did you live on in third grade?')
    SecretQuestion.create(:secret_question=>'What was the last name of your third grade teacher?')
    SecretQuestion.create(:secret_question=>'In what city does your nearest sibling live?')
  end

  def self.down
    drop_table :secret_questions
  end
end
