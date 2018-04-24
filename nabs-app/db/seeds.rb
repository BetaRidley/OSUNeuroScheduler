# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# To create first clinics and users, type the following in rails console:
# Clinic.create(name: 'CLINIC Referring', role: 'referrer')
# Clinic.create(name: 'Clinic Referred', role: 'referred')

# User.create!(email: "staff@gmail.com", password: "password", password_confirmation: "password", role: "staff", confirmed_at: Time.now.utc, password_changed: true, clinic_id: 1)
# User.create!(email: "referringdoctor@gmail.com", password: "password", password_confirmation: "password", role: "doctor", confirmed_at: Time.now.utc, password_changed: true, clinic_id: 1)
# User.create!(email: "referreddoctor@gmail.com", password: "password", password_confirmation: "password", role: "doctor", confirmed_at: Time.now.utc, password_changed: true, clinic_id: 2)
# User.create!(email: "admin@gmail.com", password: "password", password_confirmation: "password", role: "admin", confirmed_at: Time.now.utc, password_changed: true, clinic_id: 2)

#Specialization.create!(title: "Optometry"