class AddStateColumnToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :state, :integer, default: 0
  end
end
