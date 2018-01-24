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

require 'rails_helper'

RSpec.describe Referral, type: :model do
  describe 'associations' do
    it { should belong_to(:created_by) }
    it { should belong_to(:patient) }
    it { should belong_to(:referring_doctor) }
    it { should belong_to(:referred_doctor) }
    it { should belong_to(:specialization) }
  end
  describe 'required fields' do #none
  end
  describe 'methods' do #none
  end
end
