class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.integer :companion_id
      t.references :user
      t.boolean :block, :default=>false
      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
