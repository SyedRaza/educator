class CreateEmploymentHistories < ActiveRecord::Migration
  def self.up
    create_table :employment_histories do |t|
     
      t.string :position
      t.string :role_description
      t.string :grades
      t.string :subjects
      t.string :my_interest
      t.date :start_date
      t.date :end_date
      t.references :employer
      t.references :user
      
      t.timestamps
    end
  end

  def self.down
    drop_table :employment_histories
  end
end
