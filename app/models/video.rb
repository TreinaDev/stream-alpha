class Video < ApplicationRecord
  belongs_to :streamer
  belongs_to :game_category

  validates :name, :description, :link, presence: true, on: :create
end
