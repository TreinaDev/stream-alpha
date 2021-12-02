class Plan < ApplicationRecord
  has_many :content_streamers, dependent: :destroy
  has_many :streamers, through: :content_streamers
  has_many :content_playlists, dependent: :destroy
  has_many :playlists, through: :content_playlists

  validates :name, :description, :value, presence: true
  validates :value, numericality: true

  enum plan_status: { down: 0, qualified: 1, not_qualified: 2 }

  def register_plan_api(plan)
    response = Faraday.post('http://localhost:4000/api/v1/products',
                            { product: { name: plan.name, type_of: 'subscription', status: 'enabled' } },
                            { companyToken: Rails.configuration.payment_api['company_auth_token'] })
    case response.status
    when 201
      plan.plan_token = JSON.parse(response.body, simbolize_names: true)['token']
      plan.qualified!
    when 500, 422
      nil
    end
  end
end
