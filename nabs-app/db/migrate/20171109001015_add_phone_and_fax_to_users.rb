class AddPhoneAndFaxToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :phone, :string
    add_column :users, :fax, :string
  end
end
