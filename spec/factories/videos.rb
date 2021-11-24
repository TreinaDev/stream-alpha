FactoryBot.define do
  factory :video do
    name { 'Jogando Mind Craft' }
    description { 'Jogador irado, joga demais!!' }
    name_game { 'Mind Craft' }
    duration { '139:59' }
    adult { true }
    loose { true }
    link do
      "https://vimeo.com/#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}"
    end
    streamer
  end
end
