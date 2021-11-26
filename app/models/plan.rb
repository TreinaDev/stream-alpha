class Plan < ApplicationRecord
  has_many :content_streamers, dependent: :destroy
  has_many :streamers, through: :content_streamers
  has_many :content_playlists, dependent: :destroy
  has_many :playlists, through: :content_playlists
  validates :name, :description, :value, presence: true
  validates :value, numericality: true
end
