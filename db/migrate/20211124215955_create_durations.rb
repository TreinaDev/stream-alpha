class CreateDurations < ActiveRecord::Migration[6.1]
  def change
    create_table :durations do |t|
      t.integer :minutes
      t.integer :seconds

      t.timestamps
    end
  end
end
