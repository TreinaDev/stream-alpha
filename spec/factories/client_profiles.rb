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
  end
end
