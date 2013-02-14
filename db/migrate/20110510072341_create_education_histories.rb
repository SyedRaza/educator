class CreateEducationHistories < ActiveRecord::Migration
  def self.up
    create_table :education_histories do |t|
      t.string :institute_name
      t.string :institute_type
      t.string :type_of_degree
      t.string :specialization
      t.string :degree_conferred
      t.text :major_subjects
      t.string :my_interest
      t.integer :from
      t.integer :to
      t.references :user
      t.timestamps
    end
  end

  def self.down
    drop_table :education_histories
  end
end
