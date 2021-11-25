FactoryBot.define do
  factory :game do
    sequence(:name) { |n| "Jogo qualquer #{n}" }
    admin
    game_categories { build_list(:game_category, 2, admin: admin) }
  end
end
