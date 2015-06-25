class AddTimerLoaderToRoom < ActiveRecord::Migration
  def change
    add_column :rooms, :timer_loader, :string
    add_column :rooms, :timer_border, :string
  end
end
