class Video < ApplicationRecord
  belongs_to :streamer
  has_one :price, dependent: :destroy
  accepts_nested_attributes_for :price

  validates :name, :description, :link, presence: true, on: :create
  validates :feed_back, presence: true, if: :refused?

  enum status: { pending: 0, approved: 1, refused: 2 }

  def register_video_api(video)
    response = Faraday.post('http://localhost:4000/api/v1/products',
                            { product: { name: video.name } },
                            { company_token: SecureRandom.alphanumeric(20) })
    case response.status
    when 500, 422
      video.single_video_token = nil
    when 201
      video.single_video_token = JSON.parse(response.body, simbolize_names: true)['token']
    end
  end

  def reproved_with_feedback?
    refused? && feed_back_in_database.present?
  end
end
