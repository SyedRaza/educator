class CreateContactTypes < ActiveRecord::Migration
  def self.up
    create_table :contact_types do |t|
      t.string :title
      t.references :user
      t.boolean :default_groups, :default => true
      t.integer :visibility_flag

      t.timestamps
    end
    ContactType.create(:title=>'Public', :visibility_flag=>1)
    ContactType.create(:title=>'Colleagues', :visibility_flag=>2)
    ContactType.create(:title=>'Best Friends', :visibility_flag=>4)
  end

  def self.down
    drop_table :contact_types
  end
end
