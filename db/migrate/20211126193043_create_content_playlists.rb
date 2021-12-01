class CreateContentPlaylists < ActiveRecord::Migration[6.1]
  def change
    create_table :content_playlists do |t|
      t.references :plan, null: false, foreign_key: true
      t.references :playlist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
