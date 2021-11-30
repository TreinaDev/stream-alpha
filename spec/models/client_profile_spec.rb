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

  context 'Registration on PagaPaga' do
    it 'successfully: response == 201' do
      client_profile = create(:client_profile)
      api_response = File.read(Rails.root.join('spec/support/apis/client_registration_201.json'))
      fake_response = double('faraday_response', status: 201, body: api_response)
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/customers',
                                            { name: client_profile.full_name, cpf: client_profile.cpf },
                                            { company_token: Rails.configuration.payment_api['company_auth_token'] })
                                      .and_return(fake_response)

      client_profile.register_client_api(client_profile.client)

      expect(client_profile.client_token_status).to eq('accepted')
      expect(client_profile.token).to eq('XpD75xP4lQ')
    end

    it 'unsuccessfully: response == 401' do
      client_profile = create(:client_profile)
      fake_response = double('faraday_response', status: 401, body: '')
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/customers',
                                            { name: client_profile.full_name, cpf: client_profile.cpf },
                                            any_args)
                                      .and_return(fake_response)
      client_profile.register_client_api(client_profile.client)

      expect(client_profile.client_token_status).to eq('pending')
      expect(client_profile.token).to eq(nil)
    end

    it 'unsuccessfully: response == 422' do
      client_profile = create(:client_profile)
      api_response = File.read(Rails.root.join('spec/support/apis/client_registration_error_422_full.json'))
      fake_response = double('faraday_response', status: 422, body: api_response)
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/customers',
                                            any_args,
                                            { company_token: Rails.configuration.payment_api['company_auth_token'] })
                                      .and_return(fake_response)
      client_profile.register_client_api(client_profile.client)

      expect(client_profile.client_token_status).to eq('pending')
      expect(client_profile.token).to eq(nil)
    end

    it 'unsuccessfully: response == 500' do
      client_profile = create(:client_profile)
      fake_response = double('faraday_response', status: 500, body: '')
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/customers',
                                            { name: client_profile.full_name, cpf: client_profile.cpf },
                                            { company_token: Rails.configuration.payment_api['company_auth_token'] })
                                      .and_return(fake_response)
      client_profile.register_client_api(client_profile.client)

      expect(client_profile.client_token_status).to eq('pending')
      expect(client_profile.token).to eq(nil)
    end
  end
end
