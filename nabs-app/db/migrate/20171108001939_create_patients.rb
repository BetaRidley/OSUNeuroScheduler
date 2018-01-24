class CreatePatients < ActiveRecord::Migration[5.1]
  def change
    create_table :patients do |t|
            t.string :ssn
            t.string :first_name
            t.string :last_name
            t.string :middle_name
            t.integer :sex
            t.date :birth_date
            t.string :cell_number
            t.string :home_number
            t.string :office_number
            t.string :fax_number
            
            t.timestamps
    end
  end
end
