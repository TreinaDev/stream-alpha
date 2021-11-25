require 'rails_helper'

describe 'Some' do
  context 'Admin' do
    it 'click the link to registrate a new admin' do
      admin = create(:admin)
      login_as admin, scope: :admin

      visit root_path
      click_on 'Área do administrador'
      click_on 'Cadastrar novo Administrador'

      expect(page).to have_content('Informe os dados de cadastro do novo Administrador')
    end

    it 'register a new admin successfully' do
      admin = create(:admin)
      login_as admin, scope: :admin

      visit root_path
      click_on 'Área do administrador'
      click_on 'Cadastrar novo Administrador'
      fill_in 'Email', with: 'apolo@gamestream.com.br'
      fill_in 'Senha', with: '7777777'
      click_on 'Cadastrar'

      expect(page).to have_content('Administrador cadastrado com sucesso!')
    end
  end
end
