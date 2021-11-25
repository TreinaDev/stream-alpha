class Video < ApplicationRecord
  belongs_to :streamer

  validates :name, :description, :link, presence: true, on: :create
  validates :feed_back, presence: true, if: :refused?

  enum status: { pending: 0, approved: 1, refused: 2 }

  def reproved_with_feedback?
    refused? && feed_back_in_database.present?
  end
end
