require 'message_box/class_methods'

module Nazar
  module MessageBox
    # When included in any model
    def self.included(recipient)
      recipient.extend(Nazar::MessageBox::ClassMethods)
    end

    mattr_accessor :send_email_notifications
    @@send_email_notifications = false

    mattr_accessor :email_notification_subject
    @@email_notification_subject = "You have incoming message"

    mattr_accessor :email_notification_host
    @@email_notification_host = "localhost:3000"

    mattr_accessor :email_notification_from
    @@email_notification_from = "no-reply@yoursite.com"

    def self.setup
      yield self
    end
  end
end