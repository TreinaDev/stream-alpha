require 'rails_helper'

describe 'client buys a video' do
  context 'from the videos show page' do
    it 'successfully view payment methods via API' do
      payment_methods = []
      payment_methods << PaymentMethod.new({ name: "Pix", status: "Ativo" })
      payment_methods << PaymentMethod.new({ name: "Cartão crédito", status: "Ativo" })
      payment_methods << PaymentMethod.new({ name: "Boleto", status: "Ativo" })
      allow(PaymentMethod).to receive(:all).and_return(payment_methods)
      client = create(:client)
      byebug
      
      login_as client, scope: :client
      visit root_path
      click_on 'Ver todos os videos avulsos'
      click_on video.name
      click_on 'Comprar Video'

      expect(current_path).to eq(video_payment_path(video.id))
      expect(page).to have_content('Escolha um meio de pagamento:')
      expect(page).to have_content('Pix')
      expect(page).to have_content('Cartão de credito')
      expect(page).to have_content('Boleto')
    end
  end
end