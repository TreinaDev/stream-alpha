class CreditCardSetting < ApplicationRecord
  belongs_to :customer_payment_method

  def credit_card_api_registration(api_params)
    response = faraday_credit_card_registration_call(api_params)
    case response.status
    when 500
      nil
    when 422
      # JSON.parse(response.body, simbolize_names: true)['message']['errors']
    when 201
      self.token = JSON.parse(response.body, simbolize_names: true)['customer_payment_method']['token']
    end
  end

  private

  def faraday_credit_card_registration_call(api_params)
    Faraday.post('http://localhost:4000/api/v1/customer_payment_methods',
                 { customer_payment_method: api_params },
                 { company_token: Rails.configuration.payment_api['company_auth_token'] })
  end
end
