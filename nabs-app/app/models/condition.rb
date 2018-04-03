# == Schema Information
#
# Table name: conditions
#
#  id                :integer          not null, primary key
#  name              :string           not null
#  specialization_id :integer

class Condition < ApplicationRecord
  belongs_to :specialization
end
