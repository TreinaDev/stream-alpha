FactoryBot.define do
  factory :client do
    sequence(:email) { |n| "client#{n}@user.com" }
    password { '123456' }
  end
end
