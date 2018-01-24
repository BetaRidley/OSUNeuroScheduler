class UpdateUsingClinic < ActiveRecord::Migration[5.1]
  def change
    # modding clinic
    remove_column :clinics, :location, :string
    add_column :clinics, :address_line1, :string
    add_column :clinics, :address_line2, :string
    add_column :clinics, :city,  :string
    add_column :clinics, :state, :string, limit: 2
    add_column :clinics, :zip_code, :string

    #dropping redundancy
    remove_column :users, :address_line1, :string
    remove_column :users, :address_line2, :string
    remove_column :users, :city, :string
    remove_column :users, :state, :string
    remove_column :users, :zip_code, :string
  end
end
