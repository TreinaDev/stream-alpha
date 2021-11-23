class CreateGamesGameCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :games_game_categories do |t|
      t.references :game_category, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
