class AddAdultToVideo < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :adult, :boolean
  end
end
