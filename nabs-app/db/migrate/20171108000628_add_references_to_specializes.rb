class AddReferencesToSpecializes < ActiveRecord::Migration[5.1]
  def change
          add_reference :specializes, :users, index: true, foreign_key: true, column: :doctor_id
          add_reference :specializes, :specializations, index: true, foreign_key: true
  end
end
