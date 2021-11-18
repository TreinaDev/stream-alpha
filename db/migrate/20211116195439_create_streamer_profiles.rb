class CreateStreamerProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :streamer_profiles do |t|
      t.string :name
      t.string :description
      t.string :facebook
      t.string :instagram
      t.string :twitter

      t.timestamps
    end
  end
end
