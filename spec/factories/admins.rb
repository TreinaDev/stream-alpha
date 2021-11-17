FactoryBot.define do
  factory :admin do
    email { 'admin@domain.com' }
    password { '123456' }
  end
end
