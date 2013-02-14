class CreateContactTypesContacts < ActiveRecord::Migration
  def self.up
    create_table :contact_types_contacts do |t|
      t.references :contact
      t.references :contact_type

      t.timestamps
    end
  end

  def self.down
    drop_table :contact_types_contacts
  end
end
