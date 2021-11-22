FactoryBot.define do
  factory :streamer do
    sequence(:email) { |n| "jogador#{n}@streamer.com" }
    password { '123456' } 
    profile_status { 10 }
  end
end
