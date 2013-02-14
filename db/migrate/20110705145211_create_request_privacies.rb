class CreateRequestPrivacies < ActiveRecord::Migration
  def self.up
    create_table :request_privacies do |t|
      t.string :title
      t.integer :visibility_flag

      t.timestamps
    end
    RequestPrivacy.create(:title=>"Public", :visibility_flag=>1)
    RequestPrivacy.create(:title=>"Friends of colleagues", :visibility_flag=>2)
    RequestPrivacy.create(:title=>"Friends of friends", :visibility_flag=>4)

  end

  def self.down
    drop_table :request_privacies
  end
end
