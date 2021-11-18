class AddProfileStatusToStreamer < ActiveRecord::Migration[6.1]
  def change
    add_column :streamers, :profile_status, :integer, default: 5
  end
end
