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
        'Nome completo (conforme documentos) deve incluir um sobrenome')
      expect(client_profile.errors.full_messages_for(:cep)).to include(
        'CEP deve ter 8 dígitos')
      expect(client_profile.errors.full_messages_for(:cpf)).to include(
        'CPF deve ter 11 dígitos')
    end
  end
end
