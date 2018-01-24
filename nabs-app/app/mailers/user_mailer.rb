class UserMailer < ActionMailer::Base
  default from: "nabs.app@gmail.com"
  layout "mailer"
  def send_enabled_message(user)
    @user = user
    mail(:to => user.email, :subject => "Test Email")
  end
  def send_new_user_message(user)
    @user = user
    mail(:to => 'nabs.app@gmail.com', :subject => "Test")
  end
end
