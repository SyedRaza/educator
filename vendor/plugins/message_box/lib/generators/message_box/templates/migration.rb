class CreateMessages < ActiveRecord::Migration

  def self.up
    create_table :messages do |t|

      t.string :subject
      t.text :body

      t.boolean :read, :default => false

      t.string :sender_type
      t.integer :sender_id

      t.string :receiver_type
      t.integer :receiver_id

      

      t.integer :reply_of

      t.boolean :trashed_by_sender, :default => false
      t.boolean :trashed_by_receiver, :default => false

      t.timestamps
    end
    create_table :uploads do |t|
      t.string    :attachment_file_name
      t.string    :attachment_content_type
      t.integer   :attachment_file_size
      t.datetime  :attachment_updated_at
      t.references :message
    end
    add_index :messages, [:receiver_type,:receiver_id,:created_at]
  end
  

  def self.down
    drop_table :messages
    drop_table :uploads
  end

end
