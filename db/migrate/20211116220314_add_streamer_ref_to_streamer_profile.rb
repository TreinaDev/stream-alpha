class AddStreamerRefToStreamerProfile < ActiveRecord::Migration[6.1]
  def change
    add_reference :streamer_profiles, :streamer, null: false, foreign_key: true
  end
end
