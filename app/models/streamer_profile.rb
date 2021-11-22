class StreamerProfile < ApplicationRecord
  belongs_to :streamer

  validates :name, :description, :streamer_id,
            presence: true

  has_one_attached :avatar

  enum status: { active: 0, inactive: 1 }

  def owner?(current_streamer_id = nil)
    return current_streamer_id == streamer.id if current_streamer_id

    current_streamer == streamer
  end
end
