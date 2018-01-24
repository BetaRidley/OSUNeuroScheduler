require 'faker'
# == Schema Information
#
# Table name: specializations
#
#  id    :integer          not null, primary key
#  title :string
#

FactoryBot.define do
  factory :specialization do
    title Faker::Superhero.power  
  end
end
