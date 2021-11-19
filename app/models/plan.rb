class Plan < ApplicationRecord
    has_many :content_streamers, dependent: :destroy
    has_many :streamer, through: :content_streamers
end
