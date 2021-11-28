class Plan < ApplicationRecord
  has_many :content_streamers, dependent: :destroy
  has_many :streamers, through: :content_streamers
  validates :name, :description, :value, presence: true
  validates :value, numericality: true

  def register_plan_api(plan)
    response = Faraday.post('http://localhost:4000/api/v1/subscription',
                            { subscription: { name: plan.name } },
                            { company_token: SecureRandom.alphanumeric(20) })
    case response.status
    when 201
      plan.plan_token = JSON.parse(response.body, simbolize_names: true)['token']
    end
  end
end
