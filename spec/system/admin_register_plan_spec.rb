require 'rails_helper'

describe 'Some' do
  context 'Admin register a video plan' do
    it 'but see the registration form before' do
      admin = create(:admin)

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Cadastrar Plano'

      expect(page).to have_content('Insira as informações do plano que deseja cadastrar')
    end

    it 'but fills wrong' do
      admin = create(:admin)
      gamer = create(:streamer, profile_status: 10)
      create(:streamer_profile, streamer: gamer)

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Cadastrar Plano'
      fill_in 'Nome do Plano', with: ''
      fill_in 'Descrição', with: ''
      fill_in 'Valor', with: ''
      select gamer.email, from: 'Selecione os Streamers incluídos no plano'
      click_on 'Criar Plano de Assinatura'

      expect(page).to have_content('Nome do Plano não pode ficar em branco')
      expect(page).to have_content('Descrição não pode ficar em branco')
      expect(page).to have_content('Valor não pode ficar em branco')
      expect(page).to have_content('Valor não é um número')
    end

    it 'successfully' do
      admin = create(:admin)
      gamer = create(:streamer, profile_status: 10)
      create(:streamer_profile, streamer: gamer)

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Cadastrar Plano'
      fill_in 'Nome do Plano', with: 'Plano Gamer'
      fill_in 'Descrição', with: 'Desbloqueia todos videos de um Streamer'
      fill_in 'Valor', with: '100'
      select gamer.email, from: 'Selecione os Streamers incluídos no plano'
      click_on 'Criar Plano de Assinatura'

      expect(page).to have_content('Plano cadastrado com sucesso!')
    end

    it 'with streamer and playlist successfully' do
      admin = create(:admin)
      gamer = create(:streamer, profile_status: 10)
      create(:streamer_profile, streamer: gamer)
      playlist = create(:playlist)
      playlist1 = create(:playlist)

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Cadastrar Plano'
      fill_in 'Nome do Plano', with: 'Plano Gamer'
      fill_in 'Descrição', with: 'Desbloqueia todos videos de um Streamer'
      fill_in 'Valor', with: '100'
      select gamer.email, from: 'Selecione os Streamer incluídos no plano'
      select playlist.name, from: 'Selecione as playlists incluídas no plano'
      select playlist1.name, from: 'Selecione as playlists incluídas no plano'
      click_on 'Criar Plano de Assinatura'

      expect(page).to have_content('Plano cadastrado com sucesso!')
      expect(page).to have_content(playlist.name)
      expect(page).to have_content(playlist1.name)
    end
  end
  context 'Admin view all plans registred' do
    it 'successfuly' do
      admin = create(:admin)
      plano_a = create(:plan)
      plano_b = create(:plan)
      plano_c = create(:plan)

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Planos de Assinatura'

      expect(page).to have_content(plano_a.name)
      expect(page).to have_content(plano_b.name)
      expect(page).to have_content(plano_c.name)
    end
  end
  context 'Client' do
    it 'try to see the plan registration form' do
      user = create(:client)

      login_as user, scope: :client
      visit new_plan_path

      expect(page).to have_content('Para continuar, efetue login ou registre-se.')
    end
  end
  context 'Streamer' do
    it 'try to see the plan registration form' do
      streamer = create(:streamer)

      login_as streamer, scope: :streamer
      visit new_plan_path

      expect(page).to have_content('Para continuar, efetue login ou registre-se.')
    end
  end
  context 'Person not logged in' do
    it 'try to see the plan registration form' do
      visit new_plan_path

      expect(page).to have_content('Para continuar, efetue login ou registre-se.')
    end
  end
end
