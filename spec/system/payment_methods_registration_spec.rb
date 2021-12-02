require 'rails_helper'

describe 'Payment methods registration' do
  context 'Unsuccessfully' do
    it 'client tries to view his payments methods when he still isnt registered in PagaPaga' do
      client = create(:client)
      create(:client_profile, client: client)
      fake_response = double('faraday_response', status: 500, body: '')
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/customers',
                                            { name: client.client_profile.full_name, cpf: client.client_profile.cpf },
                                            { companyToken: Rails.configuration.payment_api['company_auth_token'] })
                                      .and_return(fake_response)

      login_as client, scope: :client
      visit root_path
      click_on 'Meu Perfil'
      click_on 'Ver meus métodos de pagamento'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Não foi possível realizar essa ação agora. Por favor, tente novamente mais tarde')
    end
  end
end
