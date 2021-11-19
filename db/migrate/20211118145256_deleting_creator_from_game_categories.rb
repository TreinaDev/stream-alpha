class DeletingCreatorFromGameCategories < ActiveRecord::Migration[6.1]
  def change
    remove_column :game_categories, :creator
  end
end
