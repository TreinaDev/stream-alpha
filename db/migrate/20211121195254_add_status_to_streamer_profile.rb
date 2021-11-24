class AddStatusToStreamerProfile < ActiveRecord::Migration[6.1]
  def change
    add_column :streamer_profiles, :status, :integer, default: 0
  end
end
