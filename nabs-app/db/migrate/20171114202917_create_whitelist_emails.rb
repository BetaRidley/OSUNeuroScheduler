class CreateWhitelistEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :whitelist_emails do |t|
	    t.string :email, unique: :true
	    t.boolean :verified
            t.timestamps
    end
  end
end
