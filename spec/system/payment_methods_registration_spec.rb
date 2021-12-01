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
      cpm = create(:customer_payment_method, client_profile: client_profile, boleto_token: "KDE3V0O07j17WGSoFGRC", pix_token: "VI3wjoM7il0VIOtkl4aj")
      
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
  end
end
