require 'faker'
# == Schema Information
#
# Table name: patients
#
#  id            :integer          not null, primary key
#  ssn           :string
#  first_name    :string
#  last_name     :string
#  middle_name   :string
#  sex           :integer
#  birth_date    :date
#  fax_number    :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  insurance     :string
#  plan_group_no :integer
#  address_line1 :string
#  address_line2 :string
#  city          :string
#  state         :string(2)
#  zip_code      :string
#  email         :string
#  phone_number  :integer
#

FactoryBot.define do
  factory :patient do
    first_name Faker::Name.first_name
    middle_name Faker::Name.last_name
    last_name Faker::Name.last_name
   
    birth_date Faker::Date.birthday
    sex ['F','M','U'].sample
    ssn Faker::Number.number(9)
    insurance "#{Faker::Company.name} Insurance"
    plan_group_no Faker::Number.number(5)

    phone_number '999999999'
    fax_number '999999999'
    email Faker::Internet.safe_email

    address_line1 Faker::Address.street_address
    address_line2 Faker::Address.secondary_address
    city Faker::Address.city
    state Faker::Address.state_abbr
    zip_code Faker::Address.zip_code
  end
end
