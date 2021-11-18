class AddIndex < ActiveRecord::Migration[6.1]
  def change
    add_index :game_categories, :name, unique: true
  end
end
