require 'faker'
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
#

FactoryBot.define do
  factory :user, aliases: [:referring_doctor, :referred_doctor, :created_by] do
    first_name Faker::Name.first_name
    middle_name Faker::Name.last_name
    last_name Faker::Name.last_name

    phone_number '9999999999' 
    fax_number '9999999999'
    sequence(:email) {|n| "nabs.app#{n}@gmail.com" }
    password 'password'
    association :clinic
    role 'admin'

    trait :referring_doctor do
      role 'doctor'
    end

    trait :referred_doctor do
      role 'doctor'
      association :clinic, :referred
    end
    
    trait :admin do
      role 'admin'
    end
    trait :staff do
      role 'staff'
    end
    trait :referred_staff do
      role 'staff'
      association :clinic, :referred
    end
    trait :confirmed do
      password_confirmation 'password'
      password_changed true
      confirmed_at Time.now.utc
    end
  end
end
