class StreamerProfile < ApplicationRecord
  belongs_to :streamer

  validates :name, :description, :streamer_id,
            presence: true

  has_one_attached :avatar

  private

  def owner?
    streamer_signed_in? && current_streamer == @streamer_profile.streamer
  end
end
