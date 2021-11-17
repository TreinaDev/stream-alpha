FactoryBot.define do
  factory :streamer do
    sequence(:email) { |n| "streamer#{n}@domain.com" }
    password { '123456' }
  end
end
