require 'rails_helper'

describe 'Some' do
  context 'Admin' do
    it 'click the link to registrate a new streamer' do
      admin = create(:admin)
      login_as admin, scope: :admin

      visit root_path
      click_on 'Área do administrador'
      click_on 'Streamer'

      expect(page).to have_content('Informe os dados de cadastro do novo Streamer')
    end

    it 'register a new streamer successfully' do
      admin = create(:admin)
      login_as admin, scope: :admin

      visit root_path
      click_on 'Área do administrador'
      click_on 'Streamer'
      fill_in 'Email', with: 'apolo@user.com'
      fill_in 'Senha', with: '7777777'
      click_on 'Cadastrar'

      expect(page).to have_content('Streamer cadastrado com sucesso!')
    end

    it 'register a new streamer but fills wrong' do
      admin = create(:admin)
      login_as admin, scope: :admin

      visit root_path
      click_on 'Área do administrador'
      click_on 'Streamer'
      fill_in 'Email', with: ''
      fill_in 'Senha', with: ''
      click_on 'Cadastrar'

      expect(page).to have_content('Email não pode ficar em branco')
      expect(page).to have_content('Senha não pode ficar em branco')
    end
  end
  context 'Client' do
    it 'try to see the streamer registration form' do
      user = create(:client)

      login_as user, scope: :client
      visit new_streamer_path

      expect(page).to have_content('Para continuar, efetue login ou registre-se.')
    end
  end
  context 'Streamer' do
    it 'try to see the streamer registration form' do
      streamer = create(:streamer)

      login_as streamer, scope: :streamer
      visit new_streamer_path

      expect(page).to have_content('Para continuar, efetue login ou registre-se.')
    end
  end
  context 'Person not logged in' do
    it 'try to see the streamer registration form' do
      visit new_streamer_path

      expect(page).to have_content('Para continuar, efetue login ou registre-se.')
    end
  end
end
