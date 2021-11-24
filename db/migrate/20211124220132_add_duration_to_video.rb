class AddDurationToVideo < ActiveRecord::Migration[6.1]
  def change
    add_reference :videos, :duration, null: false, foreign_key: true
  end
end
