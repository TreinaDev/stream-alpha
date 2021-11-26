require 'rails_helper'

RSpec.describe ClientProfile, type: :model do
  describe 'presence validations' do
    subject { ClientProfile.new }

    it { should validate_presence_of(:full_name).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:social_name).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:birth_date).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:cpf).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:cep).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:city).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:state).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:residential_number).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:residential_address).with_message('não pode ficar em branco') }
  end

  context 'custom validations' do
    it 'full_name must have a surname, cpf needs to have 11 digits and cep needs to have 8 digits' do
      client_profile = ClientProfile.new(full_name: 'Otávio', cep: '0815053', cpf: '608154958')
      client_profile.valid?

      expect(client_profile.errors.full_messages_for(:full_name)).to include(
        'Nome completo (conforme documentos) deve incluir um sobrenome'
      )
      expect(client_profile.errors.full_messages_for(:cep)).to include(
        'CEP deve ter 8 dígitos'
      )
      expect(client_profile.errors.full_messages_for(:cpf)).to include(
        'CPF deve ter 11 dígitos'
      )
    end

    it 'image cannot be grater than 2 Mb' do
      photo_profile = ClientProfile.new(photo: Rack::Test::UploadedFile
        .new(Rails.root.join('spec/support/assets/4mb_photo.jpg')))
      photo_profile.valid?

      expect(photo_profile.errors.full_messages_for(:photo)).to include(
        'Foto do Perfil deve ser menor que 2Mb'
      )
    end
  end
  # context 'must create a client_token on pagapaga after profile creation' do
  #   it 'successfully - must return an array' do
  #     api_response = File.read(Rails.root.join('spec/support/apis/client_registration.json'))
  #     fake_response = double('faraday_response', status: 200, body: api_response)

  #     allow(Faraday).to receive(:post).with('http://pagapaga.com.br/api/v1/client_registration/')
  #                                    .and_return(fake_response)
      
  #     result = PaymentMethod.all

  #     expect(result.length).to eq 3
  #     expect(result[0].name).to eq 'Boleto'
  #     expect(result[0].status).to eq 'Ativo'
  #     expect(result[1].name).to eq 'Cartão de crédito'
  #     expect(result[1].status).to eq 'Ativo'
  #     expect(result[2].name).to eq 'Pix'
  #     expect(result[2].status).to eq 'Ativo'
  #   end
  # end
end
