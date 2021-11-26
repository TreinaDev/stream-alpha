class AddGameRefToVideo < ActiveRecord::Migration[6.1]
  def change
    add_reference :videos, :game, null: false, foreign_key: true
  end
end
