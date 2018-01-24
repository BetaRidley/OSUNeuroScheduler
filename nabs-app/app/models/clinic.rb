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

class Clinic < ApplicationRecord
  enum role: [:referred, :referrer]
  has_many :users, class_name: "User"
  validates :name, presence: true
  #validates_formatting_of :email, using: :email, allow_blank: true
  #validates_formatting_of :phone_number, using: :us_phone, allow_blank: true
  #validates_formatting_of :fax_number, using: :us_phone, allow_blank: true
  #validates_formatting_of :zip_code, :using => :us_zip, allow_blank: true
  def set_role
    self.role ||= :referrer
  end
  def referrer?
    self.role == 'referrer'
  end
  def referred?
    self.role == 'referred'
  end
  def referring_doctors
    self.users.where(role: 'doctor') if self.referrer?
  end
  def referred_doctors
    self.users.where(role: 'doctor') if self.referred?
  end
end
