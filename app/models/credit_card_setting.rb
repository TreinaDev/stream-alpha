class CreditCardSetting < ApplicationRecord
  belongs_to :customer_payment_method

  def credit_card_api_registration(_current_client, api_params)
    response = faraday_credit_card_registration_call(api_params)
    case response.status
    when 500, 422
      nil
    when 201
      self.token = JSON.parse(response.body, simbolize_names: true)['customer_payment_method']['token']
      encrypt_credit_card_digits(api_params[:credit_card_number])
    end
  end

  def encrypt_credit_card_digits(credit_card_number)
    encrypted = '**** **** **** '
    (12..15).each do |index|
      encrypted += credit_card_number.to_s.chars[index]
    end
    self.encrypted_digits = encrypted
    self
  end

  private

  def faraday_credit_card_registration_call(api_params)
    Faraday.post('http://localhost:4000/api/v1/customer_payment_methods',
                 { customer_payment_method: api_params },
                 { companyToken: Rails.configuration.payment_api['company_auth_token'] })
  end
end
