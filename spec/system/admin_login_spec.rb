require 'rails_helper'

describe 'Admin login -' do
  context 'login:' do
    it 'without a admin profile' do
      admin = create(:admin)

      visit root_path
      click_on 'Como administrador'
      fill_in 'Email', with: admin.email
      fill_in 'Senha', with: admin.password
      within 'form' do
        click_on 'Entrar'
      end

      expect(current_path).to eq(root_path)
      expect(page).to have_content 'Login efetuado com sucesso!'
      expect(page).to have_content(admin.email)
    end
  end
end
