class AddDefaultToRate < ActiveRecord::Migration
  def change
    remove_column :rooms, :timer_border
    remove_column :rooms, :timer_loader
    add_column :rooms, :rate, :float, default: 1.0
  end
end
