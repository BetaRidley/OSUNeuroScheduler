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

  def send_deny_message(referral)
    @referral = referral
    @user = User.find(@referral.created_by_id)
    unless @user.email.nil? or @user.email.empty?
      mail(:to => @user.email, :subject => "Referral Denied")
    end
  end
end
