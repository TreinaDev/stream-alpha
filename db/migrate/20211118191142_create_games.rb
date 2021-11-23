class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :name
      t.date :creation_date
      t.references :admin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
