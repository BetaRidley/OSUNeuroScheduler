class CreateClinics < ActiveRecord::Migration[5.1]
  def change
    create_table :clinics do |t|
      t.text :location
      t.string :name, null: false
      t.string :phone_number
      t.string :fax_number

      t.timestamps
    end
  end
end
