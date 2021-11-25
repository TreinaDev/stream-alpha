FactoryBot.define do
  factory :video do
    sequence(:name) { |n| "\##{n} Jogando Mind Craft" }
    description { 'Jogador irado, joga demais!!' }
    link do
      "#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}"
    end
    streamer
  end
end
