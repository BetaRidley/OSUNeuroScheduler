require 'faker'
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

FactoryBot.define do
  factory :referral do
    status [0,1,2,3,4].sample

    association :patient
    association :created_by 
    association :referring_doctor, :referring_doctor
    association :referred_doctor, :referred_doctor 
    association :specialization

    sent_at Date.today

    urgent [true,false].sample
    next_available [true, false].sample

    monday [true,false].sample
    tuesday [true,false].sample
    wednesday [true,false].sample
    thursday [true,false].sample
    friday [true,false].sample
    saturday [true,false].sample
    sunday [true,false].sample
    trait :new do
      status 0
    end
    trait :edited do
      status 1
    end
    trait :sent do
      status 2 
    end
    trait :accepted do
      status 3
    end
    trait :denied do
      status 4
    end
  end
end
