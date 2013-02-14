Nazar::MessageBox.setup do |config|

  # Send email or not
  config.send_email_notifications   = false

  # Title of the message
  config.email_notification_subject = "You have incoming message"

  # Message sent from this email
  config.email_notification_from    = "no-reply@yoursite.com"


  # ActionMailer Host
  config.email_notification_host    = "localhost:3000"
end