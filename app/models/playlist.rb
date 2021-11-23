class Playlist < ApplicationRecord
  belongs_to :admin

  has_one_attached :cover

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
