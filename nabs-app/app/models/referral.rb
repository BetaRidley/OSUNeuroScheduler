# == Schema Information
#
# Table name: referrals
#
#  id                  :integer          not null, primary key
#  status              :integer
#  date                :date
#  created_by_id       :integer
#  patient_id          :integer
#  referring_doctor_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  referred_doctor_id  :integer
#  sent_at             :datetime
#  urgent              :boolean          default(FALSE)
#  next_available      :boolean          default(FALSE)
#  monday              :boolean          default(FALSE)
#  tuesday             :boolean          default(FALSE)
#  wednesday           :boolean          default(FALSE)
#  thursday            :boolean          default(FALSE)
#  friday              :boolean          default(FALSE)
#  saturday            :boolean          default(FALSE)
#  sunday              :boolean          default(FALSE)
#  specialization_id   :integer
#

class Referral < ApplicationRecord
  belongs_to :patient, class_name: 'Patient', optional: true
  belongs_to :created_by, class_name: 'User', foreign_key: :created_by_id
  belongs_to :referring_doctor, class_name: 'User', foreign_key: :referring_doctor_id, optional: true
  belongs_to :referred_doctor, class_name: 'User', foreign_key: :referred_doctor_id, optional: true
  belongs_to :specialization, class_name: 'Specialization', foreign_key: 'specialization_id', optional: true
  scope :from_clinic, ->(c) {
    joins(:created_by).
    where(users: {clinic_id: c.id})
  }
end
