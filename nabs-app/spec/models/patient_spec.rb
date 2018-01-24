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

require 'rails_helper'

RSpec.describe Patient, type: :model do
  describe 'associations' do #none
  end
  describe 'required fields' do
    subject { Patient.new() }
  end
  describe 'methods' do #none
  end
end
