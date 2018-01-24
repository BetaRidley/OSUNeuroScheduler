class UpdateUser < ActiveRecord::Migration[5.1]
  def change
    #rename columns
    rename_column :users, :phone, :phone_number
    rename_column :users, :fax, :fax_number

    # add fields
    add_column :users, :first_name, :string
    add_column :users, :middle_name, :string
    add_column :users, :last_name, :string
    add_column :users, :address_line1, :string
    add_column :users, :address_line2, :string
    add_column :users, :city, :string
    add_column :users, :state, :string, limit: 2
    add_column :users, :zip_code, :string
    add_reference :users, :specialization, index: :true, foreign_key: :true
    # add location
    add_reference :users, :clinic, index: true, foreign_key: true
  end
end
