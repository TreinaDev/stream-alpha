FactoryBot.define do
  factory :playlist do
    sequence(:name) { |n| "Playlist #{n}" }
    description { 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, labore et dolore magna aliqua.' }
    admin
    trait :with_cover do
      cover do
        Rack::Test::UploadedFile.new(Rails.root.join('spec/support/assets/gary-bendig-unsplash.jpg'), 'cover/jpg')
      end
    end
    streamer
    video
  end
end
