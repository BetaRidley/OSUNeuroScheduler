class PatientMailer < ActionMailer::Base
  default from: "nabs.app@gmail.com"
  layout "mailer"
  def send_accept_message(referral)
    @referral = referral
    @patient = Patient.find(@referral.patient_id)
    unless @patient.email.nil? or @patient.email.empty?
      mail(:to => @patient.email, :subject => "Referral Accepted")
    end
  end
  def send_deny_message(referral)
    @referral = referral
    @patient = Patient.find(@referral.patient_id)
    unless @patient.email.nil? or @patient.email.empty?
      mail(:to => @patient.email, :subject => "Referral Denied")
    end
  end
end
