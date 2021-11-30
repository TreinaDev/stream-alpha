class AddSingleVideoTokenToVideo < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :single_video_token, :string
  end
end
