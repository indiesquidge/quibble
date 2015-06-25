class AddSlugToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :room_slug, :string
  end
end
