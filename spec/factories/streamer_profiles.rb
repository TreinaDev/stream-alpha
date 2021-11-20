FactoryBot.define do
  factory :streamer_profile do
    sequence(:name) { |n| "Jogador #{n}" }
    description { 'Jogo qualquer coisa' }
    facebook { 'https://www.facebook.com/SAM.MEMES.TV/' }
    instagram { 'https://www.instagram.com/southamericamemes/' }
    twitter { 'https://twitter.com/SoutAmericMemes/' }
    streamer
    trait :with_photo do
      photo do
        Rack::Test::UploadedFile.new(Rails.root.join('spec/support/assets/gary-bendig-6GMq7AGxNbE-unsplash.jpg'),
                                     'photo/jpg')
      end
    end
  end
end
