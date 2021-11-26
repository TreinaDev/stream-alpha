FactoryBot.define do
  factory :streamer do
    sequence(:email) { |n| "streamer#{n}@user.com" }
    password { '123456' }
    trait :profile do
      streamer_profile
    end
  end
end
