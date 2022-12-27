class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.integer :user_id
      t.integer :room_id
      t.integer :people_num
      t.date :chack_in
      t.date :check_out

      t.timestamps
    end
  end
end
