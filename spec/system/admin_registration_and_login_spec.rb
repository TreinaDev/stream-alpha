require 'rails_helper'

describe 'Admin registration and login -' do
  context 'registration:' do
    it 'successfully' do
      visit root_path
      click_on 'Entrar como Administrador'
      click_on 'Cadastre-se'
      fill_in 'Email', with: 'admin@gamestream.com.br'
      fill_in 'Senha', with: '123456789'
      fill_in 'Confirme sua senha', with: '123456789'
      click_on 'Cadastrar'

      expect(current_path).to eq(root_path)
      expect(page).to have_content 'Login efetuado com sucesso. Se não foi autorizado, ' \
                                   'a confirmação será enviada por e-mail.'
      expect(page).to have_link 'Sair', href: destroy_admin_session_path
    end
  end

  context 'login:' do
    it 'without a admin profile' do
      admin = create(:admin)

      visit root_path
      click_on 'Entrar como Administrador'
      fill_in 'Email', with: admin.email
      fill_in 'Senha', with: admin.password
      click_on 'Entrar'

      expect(current_path).to eq(root_path)
      expect(page).to have_content 'Login efetuado com sucesso!'
      expect(page).to have_link 'Sair', href: destroy_admin_session_path
    end
  end
end
