class AddUserIdToRoom < ActiveRecord::Migration
  def change
    add_column :rooms, :user_id, :integer, foreign_key: true, index: true
  end
end
