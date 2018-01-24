class DropWhitelistEmails < ActiveRecord::Migration[5.1]
  def change
    drop_table :whitelist_emails
  end
end
