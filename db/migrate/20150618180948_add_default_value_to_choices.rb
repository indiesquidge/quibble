class AddDefaultValueToChoices < ActiveRecord::Migration
  def change
    change_column_default :choices, :chosen, false
  end
end
