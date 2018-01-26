class UpdateReferral < ActiveRecord::Migration[5.1]
  def change
    add_column :referrals, :sent_at, :datetime
    add_column :referrals, :urgent, :boolean, default: :false
    add_column :referrals, :next_available, :boolean, default: :false
    add_column :referrals, :monday, :boolean, default: :false
    add_column :referrals, :tuesday, :boolean, default: :false
    add_column :referrals, :wednesday, :boolean, default: :false
    add_column :referrals, :thursday, :boolean, default: :false
    add_column :referrals, :friday, :boolean, default: :false
    add_column :referrals, :saturday, :boolean, default: :false
    add_column :referrals, :sunday, :boolean, default: :false

    rename_column :referrals, :seeking_id, :referred_doctor_id
    rename_column :referrals, :doctor_id, :referring_doctor_id
    add_reference :referrals, :specialization, index: :true, foreign_key: :true
  end
end
