class CreateRequests < ActiveRecord::Migration
  def self.up
    create_table :requests do |t|
      t.integer :request_id
      t.string :email
      t.text :message
      t.boolean :confirm, :default=>0
      t.boolean :block, :default=>0
      t.references :user
      t.references :contact_type

      t.timestamps
    end
  end

  def self.down
    drop_table :requests
  end
end
