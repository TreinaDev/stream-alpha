require 'rails_helper'

describe 'Some' do
  context 'Admin register a video plan' do
    it 'but see the registration form before' do
      admin = create(:admin)

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Plano'

      expect(page).to have_content('Insira as informações do plano que deseja cadastrar')
    end

    it 'but fills wrong' do
      admin = create(:admin)
      gamer = create(:streamer, profile_status: 10)
      create(:streamer_profile, streamer: gamer)

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Plano'
      fill_in 'Valor', with: ''
      click_on 'Criar Plano de Assinatura'

      expect(page).to have_content('Nome do Plano não pode ficar em branco')
      expect(page).to have_content('Descrição não pode ficar em branco')
      expect(page).to have_content('Valor não pode ficar em branco')
      expect(page).to have_content('Valor não é um número')
    end

    it 'with streamer and playlist successfully' do
      admin = create(:admin)
      gamer = create(:streamer, profile_status: 10)
      create(:streamer_profile, streamer: gamer)
      playlist = create(:playlist)
      playlist1 = create(:playlist)
      playlist2 = create(:playlist)
      api_response = File.read(Rails.root.join('spec/support/apis/plan_registration_201.json'))
      fake_response = double('faraday_response', status: 201, body: api_response)
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/products',
                                            { product: { name: 'Plano Gamer', type_of: 'subscription',
                                                         status: 'enabled' } },
                                            { company_token: Rails.configuration.payment_api['company_auth_token'] })
                                      .and_return(fake_response)

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Plano'
      fill_in 'Nome do Plano', with: 'Plano Gamer'
      fill_in 'Descrição', with: 'Desbloqueia todos videos de um Streamer'
      fill_in 'Valor', with: '100'
      select gamer.email, from: 'Selecione os Streamers incluídos no plano'
      select playlist.name, from: 'Selecione as playlists incluídas no plano'
      select playlist1.name, from: 'Selecione as playlists incluídas no plano'
      click_on 'Criar Plano de Assinatura'

      expect(page).to have_content('Plano cadastrado com sucesso!')
      expect(page).to have_content(playlist.name)
      expect(page).to have_content(playlist1.name)
      expect(page).not_to have_content(playlist2.name)
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
      click_on 'Conteúdos'
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

      expect(current_path).to eq(new_admin_session_path)
      expect(page).to have_content('Para continuar, efetue login ou registre-se.')
    end
  end
  context 'Streamer' do
    it 'try to see the plan registration form' do
      streamer = create(:streamer)

      login_as streamer, scope: :streamer
      visit new_plan_path

      expect(current_path).to eq(new_admin_session_path)
      expect(page).to have_content('Para continuar, efetue login ou registre-se.')
    end
  end
  context 'Person not logged in' do
    it 'try to see the plan registration form' do
      visit new_plan_path

      expect(current_path).to eq(new_admin_session_path)
      expect(page).to have_content('Para continuar, efetue login ou registre-se.')
    end
  end
  context 'API' do
    it 'successfully receive token from API' do
      gamer = create(:streamer_profile)
      admin = create(:admin)
      api_response = File.read(Rails.root.join('spec/support/apis/plan_registration_201.json'))
      fake_response = double('faraday_response', status: 201, body: api_response)
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/products',
                                            { product: { name: 'Plano 4', type_of: 'subscription',
                                                         status: 'enabled' } },
                                            { company_token: Rails.configuration.payment_api['company_auth_token'] })
                                      .and_return(fake_response)

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Plano'
      fill_in 'Nome do Plano', with: 'Plano 4'
      fill_in 'Descrição', with: 'Desbloqueia todos videos de um Streamer'
      fill_in 'Valor', with: '100'
      select gamer.streamer.email, from: 'Selecione os Streamers incluídos no plano'
      click_on 'Criar Plano de Assinatura'

      Plan.last.reload
      expect(Plan.last.plan_token).to eq('ag54g6sd54gas87d52jk')
      expect(page).to have_content('Plano cadastrado com sucesso!')
      expect(page).to have_content('Plano 4')
      expect(page).to have_content('Desbloqueia todos videos de um Streamer')
      expect(page).to have_content('Valor: R$ 100')
      expect(page).to have_content(gamer.name)
      expect(page).to have_content('Status do plano: Habilitado')
    end
    it 'receive error 500 status from API' do
      gamer = create(:streamer_profile)
      admin = create(:admin)
      fake_response = double('faraday_response', status: 500, body: nil)
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/products',
                                            { product: { name: 'Plano 4', type_of: 'subscription',
                                                         status: 'enabled' } },
                                            { company_token: Rails.configuration.payment_api['company_auth_token'] })
                                      .and_return(fake_response)

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Plano'
      fill_in 'Nome do Plano', with: 'Plano 4'
      fill_in 'Descrição', with: 'Desbloqueia todos videos de um Streamer'
      fill_in 'Valor', with: '100'
      select gamer.streamer.email, from: 'Selecione os Streamers incluídos no plano'
      click_on 'Criar Plano de Assinatura'

      Plan.last.reload
      expect(Plan.last.plan_token).to eq(nil)
      expect(page).to have_content('Plano 4')
      expect(page).to have_content('Desbloqueia todos videos de um Streamer')
      expect(page).to have_content('Valor: R$ 100')
      expect(page).to have_content(gamer.name)
      expect(page).to have_content('Status do plano: Pendente')
      expect(page).to have_content('Servidor pagapaga indisponivel, cadastro ficou na fila.')
    end
    it 'receive error 422 status from API' do
      gamer = create(:streamer_profile)
      admin = create(:admin)
      api_response = File.read(Rails.root.join('spec/support/apis/plan_registration_422.json'))
      fake_response = double('faraday_response', status: 422, body: api_response)
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/products',
                                            { product: { name: 'Plano 4', type_of: 'subscription',
                                                         status: 'enabled' } },
                                            { company_token: Rails.configuration.payment_api['company_auth_token'] })
                                      .and_return(fake_response)

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Plano'
      fill_in 'Nome do Plano', with: 'Plano 4'
      fill_in 'Descrição', with: 'Desbloqueia todos videos de um Streamer'
      fill_in 'Valor', with: '100'
      select gamer.streamer.email, from: 'Selecione os Streamers incluídos no plano'
      click_on 'Criar Plano de Assinatura'

      Plan.last.reload
      expect(current_path).to eq(plan_path(Plan.last))
      expect(page).to have_content('Status do plano: Pendente')
      expect(page).to have_content('Servidor pagapaga indisponivel, cadastro ficou na fila.')
      expect(api_response['message']).presence
    end
  end
end
