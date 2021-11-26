class CreateContentPlaylists < ActiveRecord::Migration[6.1]
  def change
    create_table :content_playlists do |t|

      t.timestamps
    end
  end
end
