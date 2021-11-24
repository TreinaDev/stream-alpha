FactoryBot.define do
  factory :game_category do
    sequence(:name) { |n| "Nova Categoria #{n}" }
    admin
  end
end
