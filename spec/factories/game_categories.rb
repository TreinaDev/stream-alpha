FactoryBot.define do
  factory :game_category do
    name { 'Nova Categoria' }
    creation_date { Time.zone.now.to_date }
    admin
  end
end
