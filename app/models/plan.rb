class Plan < ApplicationRecord
    has_many :content_streamers, dependent: :destroy
    has_many :streamer, through: :content_streamers
    validates :name, :description, :value, presence: true
    validates :value, numericality: true
end
