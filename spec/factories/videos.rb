FactoryBot.define do
  factory :video do
    sequence(:name) { |n| "\##{n} Jogando Mind Craft" }
    description { 'Jogador irado, joga demais!!' }
    link { rand(10_000_000..999_999_999) }
    visualization { rand(1..5_000_000) }
    game
    streamer
    trait :approved do
      status { 'approved' }
    end
    trait :refused do
      status { 'refused' }
      feed_back { 'Podia ser melhor' if refused? }
    end
  end
end
