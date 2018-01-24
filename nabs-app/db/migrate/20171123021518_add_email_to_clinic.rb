class AddEmailToClinic < ActiveRecord::Migration[5.1]
  def change
    add_column :clinics, :email, :string
  end
end
