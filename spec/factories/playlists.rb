FactoryBot.define do
  factory :playlist do
    sequence(:name) { |n| "Playlist #{n}" }
    description { 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, labore et dolore magna aliqua.' }
    admin
  end
end
