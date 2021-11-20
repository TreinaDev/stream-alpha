class RemoveCreationDateFromGameCategories < ActiveRecord::Migration[6.1]
  def change
    remove_column :game_categories, :creation_date, :string
  end
end
