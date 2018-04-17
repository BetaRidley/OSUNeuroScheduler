class ChangePatientPhoneNumberType < ActiveRecord::Migration[5.1]
  def change
    change_column :patients, :phone_number, :string
  end
end
