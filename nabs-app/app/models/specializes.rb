# == Schema Information
#
# Table name: specializes
#
#  id                 :integer          not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  users_id           :integer
#  specializations_id :integer
#

class Specializes < ApplicationRecord
  validates :users_id, presence: true
  validate :validate_user_id

  private
  def validate_user_id
          user = User.find_by_id(self.users_id)
          errors.add(:users_id, "User is not a doctor") unless user.role == "doctor"
  end
end
