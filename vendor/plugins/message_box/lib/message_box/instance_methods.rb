module Nazar
  module MessageBox
    module InstanceMethods
      def inbox(options = {})
        Message.find_received_messages self, options
      end

      def new_messages(options = {})
        Message.find_unread_received_messages self, options
      end

      def has_new_messages?
        self.new_messages.count > 0
      end

      def outbox(options = {})
        Message.find_sent_messages self, options
      end

      def read_message(message_id)
        Message.read_message self, message_id
      end

      def send_message(receiver, subject, body, attachments)
        @message = Message.new( :receiver => receiver, :sender => self, :subject => subject,
          :body => body)
        @message.save
        unless attachments.nil?
          attachments.each do |attachment|
            @message.uploads.create( :attachment=>attachment[1][:attachment] )
          end
        end
        @message.deliver_message_notification! if Nazar::MessageBox.send_email_notifications
      end

      def reply_message(message, subject, body, attachment)
        @message = Message.new(:receiver => message.sender, :sender => self, :subject => subject, :body => body, :reply_of => message.id)
        @message.save
        unless attachment.nil?
          @message.uploads.create(:attachment=>attachment)
        end
        @message.deliver_message_notification! if Nazar::MessageBox.send_email_notifications
      end

      def delete_message(message_id)
        Message.trash_message self, message_id
      end

      def get_replies(message_id)
        # test if current user is a sender/receiver of message_id else fails
        Message.find(:all, :conditions => {:reply_of => message_id})
      end
    end
  end
end
