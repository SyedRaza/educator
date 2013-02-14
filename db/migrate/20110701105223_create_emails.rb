class CreateEmails < ActiveRecord::Migration
  def self.up
    create_table :emails do |t|
      t.string :email
      t.references :user
      t.boolean :primary, :default=>false

      t.timestamps
    end
  end

  def self.down
    drop_table :emails
  end
end
