FactoryBot.define do
  factory :client_profile do
    full_name { 'Otávio Augusto da Silva Lins' }
    social_name { 'Marcelo' }
    birth_date { '19/08/1997' }
    cpf { |client_profile| client_profile.cpf = generate_cpf }
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

def generate_cpf
  cpf = "#{rand(1..9)}#{rand(1..9)}#{rand(1..9)}#{rand(1..9)}#{rand(1..9)}#{rand(1..9)}#{rand(1..9)}#{rand(1..9)}"\
        "#{rand(1..9)}#{rand(1..9)}#{rand(1..9)}"
  return cpf if cpf.index(cpf_final_digits(cpf).join).eql? 9

  generate_cpf
end

def cpf_final_digits(cpf)
  d1 = 0
  d2 = 0
  cpf.each_char.with_index do |number, index|
    d1 += number.to_i * (10 - index) * 10 if index < 9
    d2 += number.to_i * (11 - index) * 10 if index < 10
  end
  [d1 % 11, d2 % 11]
end
