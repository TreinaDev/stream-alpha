FactoryBot.define do
  factory :game do
    name { 'Jogo qualquer' }
    creation_date { Time.zone.now.to_date }
    admin
  end
end
