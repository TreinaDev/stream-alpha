FactoryBot.define do
  factory :customer_payment_method do
    boleto_token { nil }
    pix_token { nil }
    # credit_card_token { nil }
    client_profile
  end
end
