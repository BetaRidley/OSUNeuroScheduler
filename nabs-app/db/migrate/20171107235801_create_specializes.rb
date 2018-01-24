class CreateSpecializes < ActiveRecord::Migration[5.1]
  def change
    create_table :specializes do |t|
            
            t.timestamps
    end
  end
end
