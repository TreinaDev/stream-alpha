class Playlist < ApplicationRecord
  belongs_to :admin

  has_one_attached :cover
  has_many :playlist_videos
  has_many :videos, through: :playlist_videos
  has_many :playlist_streamers
  has_many :streamers, through: :playlist_streamers

  validates :name, :description, presence: true
  validates :name, uniqueness: true
  validate :acceptable_cover

  private

  def acceptable_cover
    return unless cover.attached?
    return unless cover.byte_size > 2.megabyte

    errors.add(:cover, I18n.t('file_too_large', scope: 'activerecord.errors.messages', size: '2Mb'))
  end
end
