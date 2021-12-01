class ContentPlaylist < ApplicationRecord
  belongs_to :plan
  belongs_to :playlist
end
