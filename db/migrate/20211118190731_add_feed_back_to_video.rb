class AddFeedBackToVideo < ActiveRecord::Migration[6.1]
  def change
    add_column :videos, :feed_back, :string
  end
end
