FactoryBot.define do
  factory :price do
    loose { false }
    value { loose ? rand(9.99..99.99) : 0 }
    video
  end
end
