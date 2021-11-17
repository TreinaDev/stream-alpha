class StreamerProfile < ApplicationRecord
  belongs_to :streamer

  validates :name, :description, :streamer_id,
            presence: true
  
end
