FactoryBot.define do
  factory :video do
    name { 'Jogando Mind Craft' }
    description { 'Jogador irado, joga demais!!' }
    link do
      "https://vimeo.com/#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}"
    end
    streamer
    trait :approved do
      status { 'approved' }
    end
    trait :refused do
      status { 'refused' }
    end
  end
end
