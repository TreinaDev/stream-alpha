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
      create(:client_profile, client: client,
                              client_token_status: pending, token: SecureRandom.alphanumeric(20))

      login_as client, scope: :client
      visit root_path
      click_on 'Meu Perfil'
      click_on 'Ver meus métodos de pagamento'

      expect(current_path).to eq(my_payments_path(client))
      expect(page).to have_content('Pagamento via Pix')
      expect(page).to have_content('Pagamento via Boleto')
      expect(page).to have_content('Você ainda não tem nenhum cartão de crédito cadastrado.')
      expect(page).to have_link('Clique aqui para cadastrar um novo cartão')
    end
  end
end
