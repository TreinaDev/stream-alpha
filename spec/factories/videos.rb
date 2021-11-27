FactoryBot.define do
  factory :video do
    sequence(:name) { |n| "\##{n} Jogando Mind Craft" }
    description { 'Jogador irado, joga demais!!' }
    link { rand(10_000_000..999_999_999) }
    visualization { rand(1..5_000_000) }
    game
    streamer

    # factory :price do
    #   loose { false }
    #   value { loose ? rand(9.99..99.99) : 0 }
    # end

    trait :approved do
      status { 'approved' }
    end
    trait :refused do
      status { 'refused' }
      feed_back { 'Podia ser melhor' if refused? }
    end
  end
end
