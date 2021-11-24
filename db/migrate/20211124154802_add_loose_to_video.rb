class AddLooseToVideo < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :loose, :boolean
  end
end
