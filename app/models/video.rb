class Video < ApplicationRecord
  validates :name, :description, :link, presence: true, on: :create
  belongs_to :streamer
  belongs_to :game_category
  belongs_to :game_subcategory
end
