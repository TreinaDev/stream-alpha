FactoryBot.define do
  factory :game_category do
    name { 'Nova Categoria' }
    sequence(:name) { |n| "Nova Categoria #{n}" }
    admin
  end
end
