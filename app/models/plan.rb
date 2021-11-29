class Plan < ApplicationRecord
  has_many :content_streamers, dependent: :destroy
  has_many :streamers, through: :content_streamers

  validates :name, :description, :value, presence: true
  validates :value, numericality: true

  def register_plan_api(plan)
    response = Faraday.post('http://localhost:4000/api/v1/subscriptions',
                            { subscription: { name: plan.name } },
                            { company_token: Rails.configuration.company_token['token'] }
                            )
    case response.status
    when 201
      data = JSON.parse(response.body, simbolize_names: true)
      plan.plan_token = data['token']
    when 500
      
    end
  end
end
