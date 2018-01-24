class AddRoleToClinics < ActiveRecord::Migration[5.1]
  def change
      add_column :clinics, :role, :integer
  end
end
