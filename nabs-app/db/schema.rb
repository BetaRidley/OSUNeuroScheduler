# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180416224747) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clinics", force: :cascade do |t|
    t.string "name", null: false
    t.string "phone_number"
    t.string "fax_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address_line1"
    t.string "address_line2"
    t.string "city"
    t.string "state", limit: 2
    t.string "zip_code"
    t.string "email"
    t.integer "role"
  end

  create_table "conditions", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "specialization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["specialization_id"], name: "index_conditions_on_specialization_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "ssn"
    t.string "first_name"
    t.string "last_name"
    t.string "middle_name"
    t.integer "sex"
    t.date "birth_date"
    t.string "fax_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "insurance"
    t.integer "plan_group_no"
    t.string "address_line1"
    t.string "address_line2"
    t.string "city"
    t.string "state", limit: 2
    t.string "zip_code"
    t.string "email"
    t.string "phone_number"
  end

  create_table "referrals", force: :cascade do |t|
    t.integer "status"
    t.date "date"
    t.bigint "created_by_id"
    t.bigint "patient_id"
    t.bigint "referred_doctor_id"
    t.bigint "referring_doctor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "sent_at"
    t.boolean "urgent", default: false
    t.boolean "next_available", default: false
    t.boolean "monday", default: false
    t.boolean "tuesday", default: false
    t.boolean "wednesday", default: false
    t.boolean "thursday", default: false
    t.boolean "friday", default: false
    t.boolean "saturday", default: false
    t.boolean "sunday", default: false
    t.bigint "specialization_id"
    t.index ["created_by_id"], name: "index_referrals_on_created_by_id"
    t.index ["patient_id"], name: "index_referrals_on_patient_id"
    t.index ["referred_doctor_id"], name: "index_referrals_on_referred_doctor_id"
    t.index ["referring_doctor_id"], name: "index_referrals_on_referring_doctor_id"
    t.index ["specialization_id"], name: "index_referrals_on_specialization_id"
  end

  create_table "specializations", force: :cascade do |t|
    t.string "title"
  end

  create_table "specializes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "users_id"
    t.bigint "specializations_id"
    t.index ["specializations_id"], name: "index_specializes_on_specializations_id"
    t.index ["users_id"], name: "index_specializes_on_users_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.string "phone_number"
    t.string "fax_number"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.boolean "password_changed", default: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.bigint "specialization_id"
    t.bigint "clinic_id"
    t.boolean "auto_approve", default: false
    t.index ["clinic_id"], name: "index_users_on_clinic_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["specialization_id"], name: "index_users_on_specialization_id"
  end

  add_foreign_key "conditions", "specializations"
  add_foreign_key "referrals", "patients"
  add_foreign_key "referrals", "specializations"
  add_foreign_key "referrals", "users", column: "created_by_id"
  add_foreign_key "referrals", "users", column: "referring_doctor_id"
  add_foreign_key "specializes", "specializations", column: "specializations_id"
  add_foreign_key "specializes", "users", column: "users_id"
  add_foreign_key "users", "clinics"
  add_foreign_key "users", "specializations"
end
