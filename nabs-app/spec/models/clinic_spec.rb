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

require 'rails_helper'

RSpec.describe Clinic, type: :model do
  describe 'associations' do #none
    it { should have_many(:users) }
  end
  describe 'required fields' do
    subject { Clinic.new() }
    it { should validate_presence_of(:name) }
  end
  describe 'methods' do #none
  end
end
