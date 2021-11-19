class CreateGameCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :game_categories do |t|
      t.string :name
      t.string :creation_date
      t.string :creator

      t.timestamps
    end
  end
end
