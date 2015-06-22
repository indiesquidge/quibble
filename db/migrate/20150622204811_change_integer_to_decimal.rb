class ChangeIntegerToDecimal < ActiveRecord::Migration
  def change
    change_column :rooms, :rate, :float, default: 1.0
  end
end
