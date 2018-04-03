class CreateConditions < ActiveRecord::Migration[5.1]
  def change
    create_table :conditions do |t|
      t.string :name, null: false
      t.references :specialization, index: true, foreign_key: { to_table: :specializations }
      t.timestamps
    end
  end
end
