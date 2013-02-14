class SendMailer < ActionMailer::Base

  
def registration_confirmation(name, email, sender_name, sender_id)
    @name = name
    @user = sender_name
    @user_id = sender_id
    @url = 'http://localhost:3000'
    mail(:to => email, :subject => "#{@user} wants to add you as a contact on educatorsplanet") do |format|
      format.html
    end
  end

  def invitation_mail(to_email, user, email_body)
    @message = email_body
    @name = "#{user.first_name} #{user.last_name}"
    mail(:to => to_email, 
      :subject => "#{user.first_name} #{user.last_name} wants to add you as a contact on educatorsplanet",
      :from => user.email) do |format|
      format.html
    end
  end

end
