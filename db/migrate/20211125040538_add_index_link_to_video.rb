class AddIndexLinkToVideo < ActiveRecord::Migration[6.1]
  def change
    add_index :videos, :link, unique: true
  end
end
