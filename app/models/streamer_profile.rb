class StreamerProfile < ApplicationRecord
  belongs_to :streamer

  validates :name, :description, :streamer_id,
            presence: true

  has_one_attached :photo

  enum status: { active: 0, inactive: 1 }

  def owner?(current_streamer = nil)
    return current_streamer == streamer if current_streamer
  end
end
