class AddColumnSlugToRoom < ActiveRecord::Migration
  def change
    add_column :rooms, :slug, :string
  end
end
