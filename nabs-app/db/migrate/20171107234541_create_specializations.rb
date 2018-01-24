class CreateSpecializations < ActiveRecord::Migration[5.1]
  def change
    create_table :specializations do |t|
            t.string :title
            t.timestamp
    end
  end
end
