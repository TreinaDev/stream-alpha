class AddAdminToPlaylist < ActiveRecord::Migration[6.1]
  def change
    add_reference :playlists, :admin, null: false, foreign_key: true
  end
end
