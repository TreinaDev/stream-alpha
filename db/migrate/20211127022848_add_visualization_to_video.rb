class AddVisualizationToVideo < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :visualization, :integer, default: 0
  end
end
