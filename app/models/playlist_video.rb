class PlaylistVideo < ApplicationRecord
  belongs_to :video
  belongs_to :playlist
end
