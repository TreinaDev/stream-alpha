class Video < ApplicationRecord
  belongs_to :game
  belongs_to :streamer

  validates :name, :description, :link, presence: true
  validates :link, length: { minimum: 8, maximum: 9 }, numericality: true,
                   uniqueness: true

  validates :feed_back, presence: true, if: :refused?

  enum status: { pending: 0, approved: 1, refused: 2 }

  scope :all_in_analysis, -> { where(status: 'pending') }

  def reproved_with_feedback?
    refused? && feed_back_in_database.present?
  end
end
