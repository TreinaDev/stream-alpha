require 'rails_helper'

describe 'Some' do
  context 'Admin' do
    it 'click the link to registrate a new admin' do
      admin = create(:admin)
      login_as admin, scope: :admin

      visit root_path
      click_on 'Área do administrador'
      click_on 'Administrador'

      expect(current_path).to eq(new_admin_path)
      expect(page).to have_content('Informe os dados de cadastro do novo Administrador')
    end

    it 'register a new admin successfully' do
      admin = create(:admin)
      login_as admin, scope: :admin

      visit root_path
      click_on 'Área do administrador'
      click_on 'Administrador'
      fill_in 'Email', with: 'apolo@gamestream.com.br'
      fill_in 'Senha', with: '7777777'
      click_on 'Criar Admin'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Administrador cadastrado com sucesso!')
    end

    it 'register a new admin but fills wrong' do
      admin = create(:admin)
      login_as admin, scope: :admin

      visit root_path
      click_on 'Área do administrador'
      click_on 'Administrador'
      fill_in 'Email', with: ''
      fill_in 'Senha', with: ''
      click_on 'Criar Admin'

      expect(current_path).to eq(admins_path)
      expect(page).to have_content('Erro ao cadastrar Administrador!')
      expect(page).to have_content('Email não pode ficar em branco')
      expect(page).to have_content('deve pertencer ao domínio @gamestream.com.br')
      expect(page).to have_content('Senha não pode ficar em branco')
    end
  end

  context 'Client' do
    it 'try to see the admin registration form' do
      user = create(:client)

      login_as user, scope: :client
      visit new_admin_path

      expect(current_path).to eq(new_admin_session_path)
      expect(page).to have_content('Para continuar, efetue login ou registre-se.')
    end
  end

  context 'Streamer' do
    it 'try to see the admin registration form' do
      streamer = create(:streamer)

      login_as streamer, scope: :streamer
      visit new_admin_path

      expect(current_path).to eq(new_admin_session_path)
      expect(page).to have_content('Para continuar, efetue login ou registre-se.')
    end
  end
  context 'Person not logged in' do
    it 'try to see the admin registration form' do
      visit new_admin_path

      expect(current_path).to eq(new_admin_session_path)
      expect(page).to have_content('Para continuar, efetue login ou registre-se.')
    end
  end
end
