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

class Patient < ApplicationRecord
  has_one :referral, dependent: :destroy
  #validates_formatting_of :ssn, :using => :ssn, allow_blank: true
  #validates_formatting_of :phone_number, using: :us_phone, allow_blank: true
  #validates_formatting_of :fax_number, using: :us_phone, allow_blank: true
  #validates_formatting_of :email, using: :email, allow_blank: true
end
