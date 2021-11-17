FactoryBot.define do
  factory :streamer_profile do
    sequence(:name) { |n| "Jogador #{n}" }
    description { 'Jogo qualquer coisa' }
    facebook { 'https://www.facebook.com/fulano/' }
    instagram { 'https://www.instagram.com/fulano/' }
    twitter { 'https://twitter.com/fulano/' }
    streamer
  end
end
