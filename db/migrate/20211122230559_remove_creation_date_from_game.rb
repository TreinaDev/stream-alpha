class RemoveCreationDateFromGame < ActiveRecord::Migration[6.1]
  def change
    remove_column :games, :creation_date, :string
  end
end
