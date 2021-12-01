require 'rails_helper'

describe 'Payment methods registration' do
  context 'Unsuccessfully' do
    it 'client tries to view his payments methods when he still isnt registered in PagaPaga' do
      client = create(:client)
      create(:client_profile, client: client)

      login_as client, scope: :client
      visit root_path
      click_on 'Meu Perfil'
      click_on 'Ver meus métodos de pagamento'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Não foi possível realizar essa ação agora. Por favor, tente novamente mais tarde')
    end

    it 'client views his basic payment methods, as in pix and boleto' do
      client = create(:client)
      client_profile = create(:client_profile, client: client, client_token_status: 'accepted',
                                               token: SecureRandom.alphanumeric(20))
      cpm = create(:customer_payment_method, client_profile: client.client_profile)

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
