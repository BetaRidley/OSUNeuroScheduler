class CreateReferrals < ActiveRecord::Migration[5.1]
  def change
    create_table :referrals do |t|
            t.integer :status
            t.date :date
            t.references :created_by, index: true, foreign_key: { to_table: :users }
            t.references :patient, index: true, foreign_key: { to_table: :patients }
            t.references :seeking, index: true, foreign_key: { to_table: :specializations }
            t.references :doctor, index: true, foreign_key: { to_table: :users }
            t.timestamps
    end
  end
end
