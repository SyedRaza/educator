class MessageBoxNotifier < ActionMailer::Base
  default :host   =>Nazar::MessageBox.email_notification_host,
          :from   =>Nazar::MessageBox.email_notification_from,
          :subject=>Nazar::MessageBox.email_notification_subject


  def message_notification(message)
    @message = message
    mail(:to=>message.receiver.email)
  end
end
