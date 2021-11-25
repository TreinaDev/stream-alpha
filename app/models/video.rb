class Video < ApplicationRecord
  belongs_to :game
  belongs_to :streamer
  has_one :price, dependent: :destroy
  accepts_nested_attributes_for :price

  validates :name, :description, :link, presence: true
  validates :link, length: { minimum: 8, maximum: 9 }, numericality: true,
                   uniqueness: true

  validates :feed_back, presence: true, if: :refused?

  enum status: { pending: 0, approved: 1, refused: 2 }

  def reproved_with_feedback?
    refused? && feed_back_in_database.present?
  end
end
