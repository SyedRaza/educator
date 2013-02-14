require 'rails/generators'
require 'rails/generators/active_record'

module Nazar
  module MessageBox
    module Generators
      class MessageBoxGenerator < Rails::Generators::Base
        include Rails::Generators::Migration
        extend ActiveRecord::Generators::Migration

        namespace "message_box"
        desc "generates the migration for messages."
        source_root File.expand_path("../templates", __FILE__)

        def copy_migration_file
          migration_template 'migration.rb', 'db/migrate/create_messages'

        end

        def copy_config_file
          template 'message_box.rb', 'config/initializers/message_box.rb'
        end

        def copy_mail_notification
          copy_file 'message_notification.html.erb', 'app/views/message_box_notifier/message_notification.html.erb'
        end
      end
    end
  end
end