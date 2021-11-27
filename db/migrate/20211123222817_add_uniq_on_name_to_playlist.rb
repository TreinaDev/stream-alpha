class AddUniqOnNameToPlaylist < ActiveRecord::Migration[6.1]
  def change
    add_index :playlists, :name, unique: true
  end
end
