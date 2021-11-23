class AddStatusToVideo < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :status, :integer, default: 0
  end
end
