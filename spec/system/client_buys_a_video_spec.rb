require 'rails_helper'

describe 'client buys a video' do
  context 'from the videos show page' do
    it 'successfully view payment methods via API' do
      client = create(:client)
      client_profile = create(:client_profile, client: client)
      streamer_profile = create(:streamer_profile, name: 'Solaire')
      video = create(:video, name: 'Jogando Mind Craft', status: 'pending', link: '613710178',
                             streamer: streamer_profile.streamer)
      create(:price, loose: true, video: video)
      create(:customer_payment_method, client_profile: client_profile, boleto_token: 'KDE3V0O07j17WGSoFGRC',
                                       pix_token: 'VI3wjoM7il0VIOtkl4aj')

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
      expect(page).to have_content('Nenhum cartão de crédito registrado')
      expect(page).to have_link('Registrar novo cartão de crédito')
      expect(page).to have_content('Boleto')
    end
  end
end
