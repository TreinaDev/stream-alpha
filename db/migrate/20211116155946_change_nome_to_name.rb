class ChangeNomeToName < ActiveRecord::Migration[6.1]
  def change
    rename_column :videos, :nome, :name
  end
end
