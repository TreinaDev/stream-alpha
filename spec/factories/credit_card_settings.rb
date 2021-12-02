FactoryBot.define do
  factory :credit_card_setting do
    sequence(:nickname) { |n| "Apelido #{n}" }
    encrypted_digits { "**** **** **** #{rand(1000..9999)}" }
    token { SecureRandom.alphanumeric(20) }
    customer_payment_method
  end
end
