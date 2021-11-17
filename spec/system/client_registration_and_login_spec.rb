require 'rails_helper'

describe 'Client registration and login -' do
  context 'registration:' do
    it 'successfully' do
      visit root_path
      click_on 'Entrar como Assinante'
      click_on 'Cadastre-se'
      fill_in 'Email', with: 'client@user.com'
      fill_in 'Senha', with: '123456789'
      fill_in 'Confirme sua senha', with: '123456789'
      click_on 'Cadastrar'

      expect(current_path).to eq(new_client_profile_path)
    end
  end

  context 'login:' do
    it 'without a client profile' do
      client = create(:client)

      visit root_path
      click_on 'Entrar como Assinante'
      fill_in 'Email', with: client.email
      fill_in 'Senha', with: client.password
      click_on 'Entrar'

      expect(current_path).to eq(new_client_profile_path)
    end
  end
end
