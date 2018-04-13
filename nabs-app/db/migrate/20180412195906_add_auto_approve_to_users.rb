class AddAutoApproveToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :auto_approve, :boolean, default: false
  end
end
