# == Schema Information
#
# Table name: specializations
#
#  id    :integer          not null, primary key
#  title :string
#

class Specialization < ApplicationRecord
  has_many :users, through: :specializes
  has_many :conditions
  has_many :referrals
end
