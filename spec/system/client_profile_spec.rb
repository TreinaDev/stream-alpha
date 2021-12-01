require 'rails_helper'

describe 'Client profile' do
  context 'Creation:' do
    it 'successfully make login and create profile with token' do
      client = create(:client)
      api_response = File.read(Rails.root.join('spec/support/apis/client_registration_201.json'))
      fake_response = double('faraday_response', status: 201, body: api_response)
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/customers',
                                            { name: 'Otávio Augusto da Silva Lins', cpf: '60243105878' },
                                            { company_token: Rails.configuration.payment_api['company_auth_token'] })
                                      .and_return(fake_response)

      visit root_path
      click_on 'Entrar como Assinante'
      fill_in 'Email', with: client.email
      fill_in 'Senha', with: client.password
      click_on 'Entrar'
      fill_in 'Nome completo (conforme documentos)', with: 'Otávio Augusto da Silva Lins'
      fill_in 'Nome social', with: 'Marcela'
      fill_in 'Data de nascimento', with: '19/08/1997'
      fill_in 'CPF (apenas números)', with: '60243105878'
      fill_in 'CEP', with: '08150530'
      fill_in 'Cidade', with: 'São Paulo'
      fill_in 'Estado', with: 'SP'
      fill_in 'Endereço residencial', with: 'Avenida dos clientes'
      fill_in 'Número residencial', with: '153'
      select '16', from: 'Configuração de classificação etária'
      attach_file 'Foto', Rails.root.join('spec/support/assets/gary-bendig-unsplash.jpg')
      click_on 'Criar Perfil de Assinante'

      expect(page).to have_content('Perfil de Marcela')
      expect(page).to have_content('Data de nascimento: 19/08/1997')
      expect(page).to have_content('Configuração de classificação etária: 16')
      expect(page).to have_content('Endereço residencial: Avenida dos clientes, número 153')
      expect(page).to have_content('CEP: 08150530')
      expect(page).to have_content('Cidade: São Paulo, SP')
      expect(ClientProfile.count).to eq(1)
      expect(page).to have_css("img[src*='gary-bendig-unsplash.jpg']")
      expect(page).to_not have_content('CPF: 60243105878')
      expect(ClientProfile.find(1).token).to eq('ijlKA9Kxc7Q9vrXOtgTK')
    end
    it 'successfully logs_in with a created profile' do
      client = create(:client)
      create(:client_profile, client: client)

      visit root_path
      click_on 'Entrar como Assinante'
      fill_in 'Email', with: client.email
      fill_in 'Senha', with: client.password
      click_on 'Entrar'

      expect(current_path).to eq(root_path)
    end
    it 'unsuccessfully: left mandatory information blank' do
      client = create(:client)

      visit root_path
      click_on 'Entrar como Assinante'
      fill_in 'Email', with: client.email
      fill_in 'Senha', with: client.password
      click_on 'Entrar'
      click_on 'Criar Perfil de Assinante'

      expect(current_path).to eq client_profiles_path
      expect(page).to have_content('Erro ao criar Perfil de Assinante!')
      expect(page).to have_content(
        'Nome completo (conforme documentos) não pode ficar em branco'
      )
      expect(page).to have_content('Data de nascimento não pode ficar em branco')
      expect(page).to have_content('Endereço residencial não pode ficar em branco')
      expect(page).to have_content('Número residencial não pode ficar em branco')
      expect(page).to have_content('CEP não pode ficar em branco')
      expect(page).to have_content('Cidade não pode ficar em branco')
      expect(page).to have_content('Estado não pode ficar em branco')
      expect(ClientProfile.count).to eq(0)
    end
    it 'unsuccessfully: profile already exists' do
      client = create(:client)
      create(:client_profile, client: client)

      visit root_path
      login_as client, scope: :client
      visit new_client_profile_path

      expect(current_path).to eq client_profile_path(client.client_profile.id)
      expect(page).to have_content('Perfil já existente!')
    end
    it 'successfully: click on the link to edit profile' do
      client = create(:client)
      profile = create(:client_profile, client: client)

      login_as client, scope: :client
      visit root_path
      click_on 'Meu Perfil'
      click_on 'Editar Perfil'

      expect(current_path).to eq edit_client_profile_path(profile)
      expect(page).to have_content('Insira as informações que deseja atualizar!')
      expect(page).to have_content('CPF (apenas números) 80052514080')
    end
    it 'successfully: edit profile' do
      client = create(:client)
      create(:client_profile, :with_photo, client: client)

      login_as client, scope: :client
      visit root_path
      click_on 'Meu Perfil'
      click_on 'Editar Perfil'
      fill_in 'Nome completo (conforme documentos)', with: 'Plínio Larrubia Ferreira de Moura'
      fill_in 'Nome social', with: 'Mario'
      fill_in 'Data de nascimento', with: '22/06/1999'
      fill_in 'CEP', with: '28400000'
      fill_in 'Cidade', with: 'São Fidélis'
      fill_in 'Estado', with: 'RJ'
      fill_in 'Endereço residencial', with: 'Rua Santa Cecília'
      fill_in 'Número residencial', with: '61'
      select '18', from: 'Configuração de classificação etária'
      click_on 'Atualizar Perfil de Assinante'

      expect(current_path).to eq client_profile_path(client.client_profile)
      expect(page).to have_content('Perfil atualizado com sucesso!')
      expect(page).to have_content('Perfil de Mario')
      expect(page).to have_content('Data de nascimento: 22/06/1999')
      expect(page).to have_content('Configuração de classificação etária: 18')
      expect(page).to have_content('Endereço residencial: Rua Santa Cecília, número 61')
      expect(page).to have_content('CEP: 28400000')
      expect(page).to have_content('Cidade: São Fidélis, RJ')
      expect(page).to have_css("img[src*='gary-bendig-unsplash.jpg']")
    end
    it 'unsuccessfully: cant edit another client profile' do
      client = create(:client)
      client2 = create(:client)
      create(:client_profile, client: client)
      client_profile2 = create(:client_profile, client: client2)

      login_as client, scope: :client
      visit root_path
      visit edit_client_profile_path(client2.client_profile)

      expect(current_path).to eq root_path
      expect(page).to have_content 'Você só pode editar o seu ' \
                                   "#{I18n.t(:client_profile, scope: 'activerecord.models')}!"
      expect(page).to_not have_content(client_profile2.social_name)
      expect(page).to_not have_content(I18n.l(client_profile2.birth_date))
      expect(page).to_not have_content(client_profile2.cpf)
      expect(page).to_not have_content(client_profile2.cep)
      expect(page).to_not have_content(client_profile2.city)
      expect(page).to_not have_content(client_profile2.state)
      expect(page).to_not have_content(client_profile2.residential_number)
      expect(page).to_not have_content(client_profile2.residential_address)
      expect(page).to_not have_content(client_profile2.age_rating)
    end

    it 'unsuccessfully edit filling fields wrong' do
      client = create(:client)
      create(:client_profile, client: client)

      login_as client, scope: :client
      visit root_path
      click_on 'Meu Perfil'
      click_on 'Editar Perfil'
      fill_in 'Nome completo (conforme documentos)', with: ''
      fill_in 'Nome social', with: ''
      fill_in 'Data de nascimento', with: ''
      fill_in 'CEP', with: ''
      fill_in 'Cidade', with: ''
      fill_in 'Estado', with: ''
      fill_in 'Endereço residencial', with: ''
      fill_in 'Número residencial', with: ''
      select '18', from: 'Configuração de classificação etária'
      click_on 'Atualizar Perfil de Assinante'

      expect(current_path).to eq client_profile_path(client.client_profile)
      expect(page).to have_content('Erro ao atualizar Perfil de Assinante!')
      expect(page).to have_content('Data de nascimento não pode ficar em branco')
      expect(page).to have_content('Endereço residencial não pode ficar em branco')
      expect(page).to have_content('Número residencial não pode ficar em branco')
      expect(page).to have_content('CEP não pode ficar em branco')
      expect(page).to have_content('Cidade não pode ficar em branco')
      expect(page).to have_content('Estado não pode ficar em branco')
    end
  end
  context 'Visualization:' do
    it 'successfully view own profile, with a valid profile' do
      client = create(:client)
      client_profile = create(:client_profile, :with_photo, client: client)

      login_as client, scope: :client
      visit root_path
      click_on 'Meu Perfil'

      expect(current_path).to eq(client_profile_path(client_profile))
      expect(page).to have_content("Perfil de #{client_profile.social_name.first}")
      expect(page).to have_content("Configuração de classificação etária: #{client_profile.age_rating}")
      expect(page).to have_content(
        "Endereço residencial: #{client_profile.residential_address}, número #{client_profile.residential_number}"
      )
      expect(page).to have_content("CEP: #{client_profile.cep}")
      expect(page).to have_content("Cidade: #{client_profile.city}, #{client_profile.state}")
      expect(page).to have_css("img[src*='gary-bendig-unsplash.jpg']")
    end
    it 'unsuccessfully view own profile, cause the profile is invalid/nil' do
      client = create(:client)

      login_as client, scope: :client
      visit root_path
      click_on 'Meu Perfil'

      expect(current_path).to eq(new_client_profile_path)
    end
  end
end
