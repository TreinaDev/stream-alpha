class CreatePlaylistVideos < ActiveRecord::Migration[6.1]
  def change
    create_table :playlist_videos do |t|
      t.references :video, null: false, foreign_key: true
      t.references :playlist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
