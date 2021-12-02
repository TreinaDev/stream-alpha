require 'rails_helper'

describe 'Payment methods registration' do
  context 'Unsuccessfully' do
    it 'client tries to view his payments methods when he still isnt registered in PagaPaga' do
      client = create(:client)
      client_profile = create(:client_profile, client: client)
      fake_response = double('faraday_response', status: 500, body: '')
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/customers',
                                            { name: client_profile.full_name, cpf: client_profile.cpf },
                                            { company_token: Rails.configuration.payment_api['company_auth_token'] })
                                      .and_return(fake_response)

      login_as client, scope: :client
      visit root_path
      click_on 'Meu Perfil'
      click_on 'Ver meus métodos de pagamento'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Não foi possível realizar essa ação agora. Por favor, tente novamente mais tarde')
    end
  end

  context 'Successfully' do
    it 'client views his basic payment methods, as in pix and boleto' do
      client = create(:client)
      client_profile = create(:client_profile, client: client, client_token_status: 'accepted',
                                               token: 'ijlKA9Kxc7Q9vrXOtgTK')
      cpm = create(:customer_payment_method, client_profile: client_profile, boleto_token: 'KDE3V0O07j17WGSoFGRC',
                                             pix_token: 'VI3wjoM7il0VIOtkl4aj')

      login_as client, scope: :client
      visit root_path
      click_on 'Meu Perfil'
      click_on 'Ver meus métodos de pagamento'

      expect(current_path).to eq(client_profile_customer_payment_method_path(client_profile, cpm))
      expect(page).to have_content('Pagamento via Pix')
      expect(page).to have_content('Pagamento via Boleto')
      expect(page).to have_content('Você ainda não tem nenhum cartão de crédito cadastrado.')
      expect(page).to have_link('Clique aqui para cadastrar um novo cartão')
    end

    it 'client views a page for registering a new credit card' do
      client = create(:client)
      client_profile = create(:client_profile, client: client, client_token_status: 'accepted',
                                               token: 'ijlKA9Kxc7Q9vrXOtgTK')
      cpm = create(:customer_payment_method, client_profile: client_profile, boleto_token: 'KDE3V0O07j17WGSoFGRC',
                                             pix_token: 'VI3wjoM7il0VIOtkl4aj')

      login_as client, scope: :client
      visit root_path
      click_on 'Meu Perfil'
      click_on 'Ver meus métodos de pagamento'
      click_on 'Clique aqui para cadastrar um novo cartão'

      expect(current_path).to eq(new_client_profile_customer_payment_method_credit_card_setting_path(client_profile,
                                                                                                     cpm))
      expect(page).to have_content('Cadastro de cartão de crédito')
      expect(page).to have_content('Apelido do cartão')
      expect(page).to have_content('Nome do titular do cartão')
      expect(page).to have_content('Número do cartão')
      expect(page).to have_content('Data de validade')
      expect(page).to have_content('Código de segurança')
    end

    it 'create a new credit card via API' do
      client = create(:client)
      client_profile = create(:client_profile, client: client, client_token_status: 'accepted',
                                               token: 'ijlKA9Kxc7Q9vrXOtgTK')
      cpm = create(:customer_payment_method, client_profile: client_profile, boleto_token: 'KDE3V0O07j17WGSoFGRC',
                                             pix_token: 'VI3wjoM7il0VIOtkl4aj')
      api_response = File.read(Rails.root.join('spec/support/apis/' \
                                               'customer_payment_method_credit_card_creation_201.json'))
      fake_response = double('faraday_response', status: 201, body: api_response)
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/customer_payment_methods',
                                            {
                                              customer_payment_method: {
                                                customer_token: 'ijlKA9Kxc7Q9vrXOtgTK',
                                                type_of: 'credit_card',
                                                payment_setting_token: 'jRGpRiyoXv96LO538Hjc',
                                                credit_card_name: 'Nwando Rolfes',
                                                credit_card_number: '4191375734719591',
                                                credit_card_expiration_date: '01/2021',
                                                credit_card_security_code: '789'
                                              }
                                            },
                                            { company_token: Rails.configuration.payment_api['company_auth_token'] })
                                      .and_return(fake_response)

      login_as client, scope: :client
      visit root_path
      click_on 'Meu Perfil'
      click_on 'Ver meus métodos de pagamento'
      click_on 'Clique aqui para cadastrar um novo cartão'
      fill_in 'Apelido do cartão', with: 'VISA'
      fill_in 'Nome do titular do cartão', with: 'Nwando Rolfes'
      fill_in 'Número do cartão', with: '4191375734719591'
      fill_in 'Data de validade', with: '01/2021'
      fill_in 'Código de segurança', with: '789'
      click_on 'Cadastrar um novo cartão'

      expect(current_path).to eq(new_client_profile_customer_payment_method_credit_card_setting_path(client_profile,
                                                                                                     cpm))
    end
  end
end
