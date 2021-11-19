class Video < ApplicationRecord
  validates :name, :description, :link, presence: true, on: :create
  validates :feed_back, presence: true, on: :refuse_button
  belongs_to :streamer
  enum status: { pending: 0, approved: 1, refused: 2 }
  scope :videos_pending, ->{ where(status: 'pending')}

  def reproved_with_feedback?
    refused? && feed_back.blank?
  end
end
