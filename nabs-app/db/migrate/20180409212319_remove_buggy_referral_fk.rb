class RemoveBuggyReferralFk < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :referrals, name: 'fk_rails_b359524008'
  end
end
