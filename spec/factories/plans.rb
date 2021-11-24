FactoryBot.define do
  factory :plan do
    sequence(:name) { |n| "Plano #{n}" }
    description { 'Este plano vale cada centavo' }
    value { rand(9.99..99.99) }
  end
end
