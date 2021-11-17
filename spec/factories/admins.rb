FactoryBot.define do
  factory :admin do
    sequence(:email) { |n| "admin#{n}@gamestream.com" }
    password { '123456' }
  end
end
