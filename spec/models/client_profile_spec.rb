require 'rails_helper'

RSpec.describe ClientProfile, type: :model do
  context 'Validation:' do
    it 'Creation - Presence' do
      @client_profile = ClientProfile.new
      @client_profile.valid?

      expect(@client_profile.errors.full_messages_for(:full_name)).to include(
        'Nome completo (conforme documentos) é obrigatório(a)'
      )
      expect(@client_profile.errors.full_messages_for(:social_name)).to include(
        'Nome social é obrigatório(a)'
      )
      expect(@client_profile.errors.full_messages_for(:birth_date)).to include(
        'Data de nascimento é obrigatório(a)'
      )
      expect(@client_profile.errors.full_messages_for(:cpf)).to include(
        'CPF é obrigatório(a)'
      )
      expect(@client_profile.errors.full_messages_for(:cep)).to include(
        'CEP é obrigatório(a)'
      )
      expect(@client_profile.errors.full_messages_for(:city)).to include(
        'Cidade é obrigatório(a)'
      )
      expect(@client_profile.errors.full_messages_for(:state)).to include(
        'Estado é obrigatório(a)'
      )
      expect(@client_profile.errors.full_messages_for(:residential_number)).to include(
        'Número residencial é obrigatório(a)'
      )
      expect(@client_profile.errors.full_messages_for(:residential_address)).to include(
        'Endereço residencial é obrigatório(a)'
      )
    end
  end
end
