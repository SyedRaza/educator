class AddFieldsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :name_visibility, :integer, :default=>4
    add_column :users, :nick_name, :string
    add_column :users, :display_picture_file_name,    :string
    add_column :users, :display_picture_content_type, :string
    add_column :users, :display_picture_file_size,    :integer
    add_column :users, :display_picture_updated_at,   :datetime
    add_column :users, :gender, :boolean
    add_column :users, :date_of_birth, :date
    add_column :users, :date_of_birth_year_visibility, :integer, :default=>4
    add_column :users, :date_of_birth_visibility, :integer, :default=>4
    add_column :users, :contact_information_visibility, :integer, :default=>4
    add_column :users, :address_1, :string
    add_column :users, :address_2, :string
    add_column :users, :zip_code, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :country, :string
    add_column :users, :contact_no, :string
    add_column :users, :contact_no_visibility, :integer, :default=>4
    add_column :users, :website, :string
    add_column :users, :website_visibility, :integer, :default=>4
    add_column :users, :about_me, :text
    add_column :users, :about_me_visibility, :integer, :default=>4
    add_column :users, :facebook_name, :string
    add_column :users, :facebook_name_visibility, :integer, :default=>4
    add_column :users, :skype_name, :string
    add_column :users, :skype_name_visibility, :integer, :default=>4
    add_column :users, :linkedin_name, :string
    add_column :users, :linkedin_name_visibility, :integer, :default=>4
    add_column :users, :emails_visibility, :integer, :default=>4
    add_column :users, :employment_history_active_visibility, :integer, :default=>4
    add_column :users, :employment_history_visibility, :integer, :default=>4
    add_column :users, :education_history_visibility, :integer, :default=>4
    add_column :users, :archive_visibility, :integer, :default=>4
    add_column :users, :dashboard_comments_visibility, :integer, :default=>4
    add_column :users, :secret_answer, :string
    add_column :users, :secret_question_id, :integer
    add_column :users, :deactive, :boolean, :default => false
    add_column :users, :deactivate_reason, :text
    add_column :users, :deactivate_account_id, :integer
    add_column :users, :deactivate_account_date, :date
    add_column :users, :comment_dashboard_visibility, :integer, :default=>4
    add_column :users, :post_dashboard_visibility, :integer, :default=>4
    add_column :users, :email_visibility, :integer, :default=>4
    add_column :users, :messages_visibility, :integer, :default=>4
    add_column :users, :request_visibility, :integer, :default=>4
    add_column :users, :contacts_list_visibility, :integer, :default=>4
    add_column :users, :search_visibility, :integer, :default=>4

  end

  def self.down
    remove_column :users, :search_visibility
    remove_column :users, :contacts_list_visibility
    remove_column :users, :request_visibility
    remove_column :users, :messages_visibility
    remove_column :users, :email_visibility
    remove_column :users, :comment_dashboard_visibility
    remove_column :users, :post_dashboard_visibility
    remove_column :users, :linkedin_name_visibility
    remove_column :users, :dashboard_comments_visibility  
    remove_column :users, :archive_visibility
    remove_column :users, :education_history_visibility
    remove_column :users, :employment_history_visibility
    remove_column :users, :employment_history_active_visibility
    remove_column :users, :emails_visibility
    remove_column :users, :skype_name_visibility
    remove_column :users, :facebook_name_visibility
    remove_column :users, :about_me_visibility
    remove_column :users, :website_visibility
    remove_column :users, :contact_no_visibility
    remove_column :users, :contact_information_visibility
    remove_column :users, :date_of_birth_visibility
    remove_column :users, :date_of_birth_year_visibility
    remove_column :users, :name_visibility
    remove_column :users, :deactivate_account_date
    remove_column :users, :deactive
    remove_column :users, :deactivate_reason
    remove_column :users, :deactivate_account_id
    remove_column :users, :secret_answer
    remove_column :users, :secret_question_id
    remove_column :users, :last_name
    remove_column :users, :first_name
    remove_column :users, :nick_name
    remove_column :users, :display_picture_file_name
    remove_column :users, :display_picture_content_type
    remove_column :users, :display_picture_file_size
    remove_column :users, :display_picture_updated_at
    remove_column :users, :gender
    remove_column :users, :date_of_birth
    remove_column :users, :address_1
    remove_column :users, :address_2
    remove_column :users, :zip_code
    remove_column :users, :city
    remove_column :users, :state
    remove_column :users, :country
    remove_column :users, :contact_no
    remove_column :users, :website
    remove_column :users, :about_me
    remove_column :users, :facebook_name
    remove_column :users, :skype_name
    remove_column :users, :linkedin_name

  end
end
