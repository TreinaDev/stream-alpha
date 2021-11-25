class Video < ApplicationRecord
  belongs_to :streamer
  has_many :playlist_videos
  has_many :playlists, through: :playlist_videos

  validates :name, :description, :link, presence: true, on: :create
  validates :feed_back, presence: true, if: :refused?

  enum status: { pending: 0, approved: 1, refused: 2 }

  scope :all_in_analysis, -> { where(status: 'pending') }
  scope :available, -> { where(status: 'approved') }


  def reproved_with_feedback?
    refused? && feed_back_in_database.present?
  end
end
