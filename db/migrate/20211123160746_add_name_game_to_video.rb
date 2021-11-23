class AddNameGameToVideo < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :name_game, :string
  end
end
