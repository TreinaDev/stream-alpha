class Video < ApplicationRecord
  belongs_to :game
  belongs_to :streamer
  has_one :price, dependent: :destroy
  has_many :playlists, through: :playlist_videos
  has_many :playlist_videos, dependent: :nullify
  has_one :streamer_profile, through: :streamer
  accepts_nested_attributes_for :price

  validates :name, :description, :link, presence: true
  validates :link, length: { minimum: 8, maximum: 9 },
                   numericality: true,
                   uniqueness: true

  validates :feed_back, presence: true, if: :refused?

  enum status: { pending: 0, approved: 1, refused: 2 }

  def register_video_api(video)
    response = Faraday.post('http://localhost:4000/api/v1/products',
                            { product: { name: video.name, type_of: 'single' } },
                            { company_token: Rails.configuration.payment_api['company_auth_token'] })
    case response.status
    when 500, 422
      video.single_video_token = nil
    when 201
      video.single_video_token = JSON.parse(response.body, simbolize_names: true)['token']
    end
  end

  def update_view_counter
    return unless approved?

    self.visualization += 1
    update({ visualization: visualization })
  end
end
