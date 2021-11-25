require 'rails_helper'

describe 'client buys a video' do
  context 'from the videos show page' do
    it 'successfully view payment methods via API' do
      payment_methods = []
      payment_methods << PaymentMethod.new({ name: 'Pix', status: 'Ativo' })
      payment_methods << PaymentMethod.new({ name: 'Cartão de crédito', status: 'Ativo' })
      payment_methods << PaymentMethod.new({ name: 'Boleto', status: 'Ativo' })
      allow(PaymentMethod).to receive(:all).and_return(payment_methods)
      client = create(:client)
      video = create(:video, link: '613710178')
      create(:price, loose: true, video: video)

      login_as client, scope: :client
      visit root_path
      click_on 'Ver todos os videos avulsos'
      click_on video.name
      click_on 'Comprar Video'

      expect(current_path).to eq(payment_video_path(video.id))
      expect(page).to have_content(video.name)
      expect(page).to have_content(video.description)
      expect(page).to have_css('iframe[src*="https://player.vimeo.com/video/613710178?autoplay=1&background=0"]')
      expect(page).to have_content('Clique no meio de pagamento que você quer utilizar nessa compra')
      expect(page).to have_content('Pix')
      expect(page).to have_content('Cartão de crédito')
      expect(page).to have_content('Boleto')
    end
    it 'and should view error message for down API' do
      allow(PaymentMethod).to receive(:all).and_return(nil)
      client = create(:client)
      video = create(:video)
      create(:price, loose: true, video: video)

      login_as client, scope: :client
      visit root_path
      click_on 'Ver todos os videos avulsos'
      click_on video.name
      click_on 'Comprar Video'

      expect(page).to have_content('Não foi possível consultar os meios de pagamento no momento')
    end
  end
end
