FactoryBot.define do
  factory :game do
    name { 'Jogo qualquer' }
    admin
    game_categories { build_list(:game_category, 2, admin: admin)}
  end
end
