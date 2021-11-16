require 'rails_helper'

describe 'Client profile' do
  context 'Creation:' do
    it 'successfully through login' do
      client = create(:client)

      visit root_path
      click_on 'Entrar como Assinante'
      fill_in 'Email', with: client.email
      fill_in 'Senha', with: client.password
      click_on 'Entrar'
      fill_in 'Nome completo (conforme documentos)', with: 'Otávio Augusto da Silva Lins'
      fill_in 'Nome social', with: 'Marcelo'
      fill_in 'Data de nascimento', with: '19/08/1997'
      fill_in 'CPF (apenas números)', with: '60243105878'
      fill_in 'CEP', with: '18150530'
      fill_in 'Cidade', with: 'São Paulo'
      fill_in 'Estado', with: 'SP'
      fill_in 'Endereço residencial', with: 'Avenida dos clientes'
      fill_in 'Número residencial', with: '153'
      select '16', from: 'Configuração de classificação etária'
      click_on 'Criar perfil'

      expect(page).to have_content('Perfil de Marcelo')
      expect(page).to have_content('Data de nascimento: 19/08/1997')
      expect(page).to have_content('Configuração de classificação etária: 16')
      expect(page).to have_content('Endereço residencial: Avenida dos clientes, número 153')
      expect(page).to have_content('CEP: 18150530')
      expect(page).to have_content('Cidade: São Paulo, SP')
      expect(ClientProfile.count).to eq(1)
    end
    it 'unsuccessfully: left mandatory information blank' do
      client = create(:client)

      visit root_path
      click_on 'Entrar como Assinante'
      fill_in 'Email', with: client.email
      fill_in 'Senha', with: client.password
      click_on 'Entrar'
      fill_in 'Nome completo (conforme documentos)', with: ''
      fill_in 'Nome social', with: ''
      fill_in 'Data de nascimento', with: ''
      fill_in 'CPF (apenas números)', with: ''
      fill_in 'CEP', with: ''
      fill_in 'Cidade', with: ''
      fill_in 'Estado', with: ''
      fill_in 'Endereço residencial', with: ''
      fill_in 'Número residencial', with: ''
      click_on 'Criar perfil'

      expect(page).to have_content(
        'Nome completo (conforme documentos) é obrigatório(a)'
      )
      expect(page).to have_content('Data de nascimento é obrigatório(a)')
      expect(page).to have_content('Endereço residencial é obrigatório(a)')
      expect(page).to have_content('Número residencial é obrigatório(a)')
      expect(page).to have_content('CEP é obrigatório(a)')
      expect(page).to have_content('Cidade é obrigatório(a)')
      expect(page).to have_content('Estado é obrigatório(a)')
      expect(ClientProfile.count).to eq(0)
    end
  end
end
