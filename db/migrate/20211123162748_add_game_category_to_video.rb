class AddGameCategoryToVideo < ActiveRecord::Migration[6.1]
  def change
    add_reference :videos, :game_category, null: false, foreign_key: true
  end
end
