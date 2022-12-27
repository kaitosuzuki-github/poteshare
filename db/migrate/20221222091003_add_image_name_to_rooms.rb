class AddImageNameToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :image_name, :string, default: "default_room.jpg"
  end
end
