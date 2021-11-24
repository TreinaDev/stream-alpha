class Video < ApplicationRecord
  validates :name, :description, :link, presence: true, on: :create
  belongs_to :streamer
end
