class AddAdminToGameCategory < ActiveRecord::Migration[6.1]
  def change
    add_reference :game_categories, :admin, null: false, foreign_key: true
  end
end
