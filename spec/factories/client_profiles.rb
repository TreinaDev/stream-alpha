FactoryBot.define do
  factory :client_profile do
    full_name { 'Otávio Augusto da Silva Lins' }
    social_name { 'Marcelo' }
    birth_date { '19/08/1997' }
    cpf { '80052514080' }
    cep { '75629465' }
    city { 'Cidade dos assinantes' }
    state { 'Estado dos assinantes' }
    residential_address { 'Rua dos assinantes' }
    residential_number { '59' }
    age_rating { 'L' }
    client
    client_token_status { :pending }
    token { nil }
    trait :with_photo do
      photo do
        Rack::Test::UploadedFile.new(Rails.root.join('spec/support/assets/gary-bendig-unsplash.jpg'), 'photo/jpg')
      end
    end
  end
end
