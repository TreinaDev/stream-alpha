class AddAttrDescriptionToVideo < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :description, :string
  end
end
