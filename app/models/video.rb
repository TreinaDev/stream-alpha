class Video < ApplicationRecord
  belongs_to :game
  belongs_to :streamer
  has_one :price, dependent: :destroy
  has_many :playlists, through: :playlist_videos
  has_many :playlist_videos, dependent: :nullify
  has_one :streamer_profile, through: :streamer
  accepts_nested_attributes_for :price

  validates :name, :description, :link, presence: true
  validates :link, length: { minimum: 8, maximum: 9 },
                   numericality: true,
                   uniqueness: true

  validates :feed_back, presence: true, if: :refused?

  enum status: { pending: 0, approved: 1, refused: 2 }

  scope :all_in_analysis, -> { where(status: 'pending') }
  scope :available, -> { where(status: 'approved') }

  def update_view_counter
    self.visualization += 1
    update({ visualization: self.visualization })
  end
end
