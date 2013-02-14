# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110705145211) do

  create_table "contact_types", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.boolean  "default_groups",  :default => true
    t.integer  "visibility_flag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_types_contacts", :force => true do |t|
    t.integer  "contact_id"
    t.integer  "contact_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.integer  "companion_id"
    t.integer  "user_id"
    t.boolean  "block",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deactivate_accounts", :force => true do |t|
    t.string   "reasons"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "education_histories", :force => true do |t|
    t.string   "institute_name"
    t.string   "institute_type"
    t.string   "type_of_degree"
    t.string   "specialization"
    t.string   "degree_conferred"
    t.text     "major_subjects"
    t.string   "my_interest"
    t.integer  "from"
    t.integer  "to"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emails", :force => true do |t|
    t.string   "email"
    t.integer  "user_id"
    t.boolean  "primary",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employers", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employment_histories", :force => true do |t|
    t.string   "position"
    t.string   "role_description"
    t.string   "grades"
    t.string   "subjects"
    t.string   "my_interest"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "employer_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.string   "subject"
    t.text     "body"
    t.boolean  "read",                :default => false
    t.string   "sender_type"
    t.integer  "sender_id"
    t.string   "receiver_type"
    t.integer  "receiver_id"
    t.integer  "reply_of"
    t.boolean  "trashed_by_sender",   :default => false
    t.boolean  "trashed_by_receiver", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["receiver_type", "receiver_id", "created_at"], :name => "index_messages_on_receiver_type_and_receiver_id_and_created_at"

  create_table "request_privacies", :force => true do |t|
    t.string   "title"
    t.integer  "visibility_flag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requests", :force => true do |t|
    t.integer  "request_id"
    t.string   "email"
    t.text     "message"
    t.boolean  "confirm",         :default => false
    t.boolean  "block",           :default => false
    t.integer  "user_id"
    t.integer  "contact_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "secret_questions", :force => true do |t|
    t.string   "secret_question"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string  "name"
    t.boolean "block", :default => true
  end

  create_table "uploads", :force => true do |t|
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "message_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                               :default => "",    :null => false
    t.string   "encrypted_password",                   :limit => 128, :default => "",    :null => false
    t.string   "password_salt",                                       :default => "",    :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "name_visibility",                                     :default => 4
    t.string   "nick_name"
    t.string   "display_picture_file_name"
    t.string   "display_picture_content_type"
    t.integer  "display_picture_file_size"
    t.datetime "display_picture_updated_at"
    t.boolean  "gender"
    t.date     "date_of_birth"
    t.integer  "date_of_birth_year_visibility",                       :default => 4
    t.integer  "date_of_birth_visibility",                            :default => 4
    t.integer  "contact_information_visibility",                      :default => 4
    t.string   "address_1"
    t.string   "address_2"
    t.string   "zip_code"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "contact_no"
    t.integer  "contact_no_visibility",                               :default => 4
    t.string   "website"
    t.integer  "website_visibility",                                  :default => 4
    t.text     "about_me"
    t.integer  "about_me_visibility",                                 :default => 4
    t.string   "facebook_name"
    t.integer  "facebook_name_visibility",                            :default => 4
    t.string   "skype_name"
    t.integer  "skype_name_visibility",                               :default => 4
    t.string   "linkedin_name"
    t.integer  "linkedin_name_visibility",                            :default => 4
    t.integer  "emails_visibility",                                   :default => 4
    t.integer  "employment_history_active_visibility",                :default => 4
    t.integer  "employment_history_visibility",                       :default => 4
    t.integer  "education_history_visibility",                        :default => 4
    t.integer  "archive_visibility",                                  :default => 4
    t.integer  "dashboard_comments_visibility",                       :default => 4
    t.string   "secret_answer"
    t.integer  "secret_question_id"
    t.boolean  "deactive",                                            :default => false
    t.text     "deactivate_reason"
    t.integer  "deactivate_account_id"
    t.date     "deactivate_account_date"
    t.integer  "comment_dashboard_visibility",                        :default => 4
    t.integer  "post_dashboard_visibility",                           :default => 4
    t.integer  "email_visibility",                                    :default => 4
    t.integer  "messages_visibility",                                 :default => 4
    t.integer  "request_visibility",                                  :default => 4
    t.integer  "contacts_list_visibility",                            :default => 4
    t.integer  "search_visibility",                                   :default => 4
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
