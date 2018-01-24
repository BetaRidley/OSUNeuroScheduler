require 'faker'
# == Schema Information
#
# Table name: clinics
#
#  id            :integer          not null, primary key
#  name          :string           not null
#  phone_number  :string
#  fax_number    :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  address_line1 :string
#  address_line2 :string
#  city          :string
#  state         :string(2)
#  zip_code      :string
#  email         :string
#  role          :integer
#

FactoryBot.define do
  factory :clinic do
    role 'referrer'
    name "#{Faker::Company.name} #{Faker::Company.suffix}"
    phone_number '9999999999' 
    fax_number '9999999999'
    address_line1 Faker::Address.street_address
    address_line2 Faker::Address.secondary_address
    city Faker::Address.city
    state Faker::Address.state_abbr
    zip_code Faker::Address.zip_code
    email Faker::Internet.safe_email
    trait :referred do
      role 'referred'
    end
  end
end
