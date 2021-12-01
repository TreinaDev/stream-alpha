FactoryBot.define do
  factory :customer_payment_method do
    boleto_token { 'xn9mc8WiA1nWPXXHCZHB' }
    pix_token { 'Zn7Nc8WRp17WPXXfCZbB' }
    # credit_card_token { nil }
    client_profile
  end
end
