FactoryBot.define do
  factory :plan do
    sequence(:name) { |n| "Plano #{n}" }
    description { "Este plano vale cada centavo" }
    value { "79.99" }
  end
end
