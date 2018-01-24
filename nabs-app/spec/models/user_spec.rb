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

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do #none
    it {should belong_to(:clinic) }
    it {should have_many(:created_referrals).with_foreign_key(:created_by)}
    it {should have_many(:referrals).with_foreign_key(:referring_doctor)}
    it {should have_many(:requests).with_foreign_key(:referred_doctor)}
  end
  describe 'required fields' do
    subject { User.new() }
    it { should validate_presence_of(:email) }
  end
  describe 'methods' do
  end
end
