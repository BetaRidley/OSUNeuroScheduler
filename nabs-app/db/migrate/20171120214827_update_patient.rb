class UpdatePatient < ActiveRecord::Migration[5.1]
  def change
    # remove columns
    remove_column :patients, :home_number
    remove_column :patients, :cell_number
    remove_column :patients, :office_number
    # add columns
    add_column :patients, :insurance, :string
    add_column :patients, :plan_group_no, :integer
    add_column :patients, :address_line1, :string
    add_column :patients, :address_line2, :string
    add_column :patients, :city, :string
    add_column :patients, :state, :string, limit: 2
    add_column :patients, :zip_code, :string
    add_column :patients, :email, :string
    add_column :patients, :phone_number, :integer
  end
end
