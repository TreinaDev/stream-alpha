FactoryBot.define do
  factory :client do
    email { 'client@domain.com' }
    password { '123456' }
  end
end
