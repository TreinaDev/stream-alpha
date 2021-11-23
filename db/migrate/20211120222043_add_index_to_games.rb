class AddIndexToGames < ActiveRecord::Migration[6.1]
  def change
    add_index :games, :name, unique: true
  end
end
