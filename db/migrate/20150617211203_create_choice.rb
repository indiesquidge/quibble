class CreateChoice < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.string :title
      t.references :room, index: true, foreign_key: true
      t.boolean :chosen, default: false
    end
  end
end
