require 'rails_helper'

describe 'Admin login -' do
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
