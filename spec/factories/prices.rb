FactoryBot.define do
  factory :price do
    loose { false }
    value { rand(9.99..99.99) }
    video
  end
end
