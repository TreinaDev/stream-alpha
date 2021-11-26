class PlaylistStreamer < ApplicationRecord
  belongs_to :playlist
  belongs_to :streamer
end
