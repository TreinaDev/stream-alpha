class CreatePlaylistStreamers < ActiveRecord::Migration[6.1]
  def change
    create_table :playlist_streamers do |t|
      t.references :playlist, null: false, foreign_key: true
      t.references :streamer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
