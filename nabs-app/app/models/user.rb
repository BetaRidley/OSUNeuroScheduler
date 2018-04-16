# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :integer
#  phone_number           :string
#  fax_number             :string
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_type        :string
#  invited_by_id          :integer
#  invitations_count      :integer          default(0)
#  password_changed       :boolean          default(FALSE)
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  first_name             :string
#  middle_name            :string
#  last_name              :string
#  specialization_id      :integer
#  clinic_id              :integer
#  auto_approve           :boolean          default(FALSE)
#

class User < ApplicationRecord
  enum role: [:staff, :doctor, :admin]
  after_initialize :set_role, :if => :new_record?
  belongs_to :clinic, class_name: "Clinic", foreign_key: :clinic_id
  belongs_to :specialization, class_name: "Specialization", optional: true 
  has_many :requests, foreign_key: :referred_doctor, class_name: 'Referral'
  has_many :referrals, foreign_key: :referring_doctor, class_name: 'Referral'
  has_many :created_referrals, foreign_key: :created_by , class_name: 'Referral'
 # validates_formatting_of :phone_number, using: :us_phone, allow_blank: true
 # validates_formatting_of :fax_number, using: :us_phone, allow_blank: true
 # validates_formatting_of :email, allow_blank: true
  scope :referred, -> {
    joins(:clinic)
      .where(clinics: {role: 'referred'})
  }
  def set_role
    self.role ||= :staff
  end

  def doctor?
    self.role == "doctor"
  end
  
  def staff?
    self.role == "staff"
  end

  def admin?
    self.role == "admin"
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def password_required?
    super if confirmed?
  end

  def password_match?
    self.errors[:password] << "can't be blank" if password.blank?
    self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
    self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
    password == password_confirmation && !password.blank?
  end

  def rollback!
    restore_attributes
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :confirmable, :trackable,
          :validatable
end
