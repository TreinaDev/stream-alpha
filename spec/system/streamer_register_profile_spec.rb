require 'rails_helper'

describe 'Streamer register profile' do
  context 'login' do
    it 'and fill profile' do
      jogador = create(:streamer)

      visit root_path
      click_on 'Entrar como Streamer'
      fill_in 'Email', with: jogador.email
      fill_in 'Senha', with: jogador.password
      click_on 'Entrar'
      fill_in 'Nome', with: 'Fulano'
      fill_in 'Descrição', with: 'Jovem de 22 anos sem ter o que fazer da vida e fica fazendo live na internet'
      fill_in 'URL do Facebook', with: 'https://www.facebook.com/fulano/'
      fill_in 'URL do Instagram', with: 'https://twitter.com/fulano/'
      fill_in 'URL do Twitter', with: 'https://www.instagram.com/fulano/'
      click_on 'Criar Perfil de Streamer'

      expect(current_path).to eq streamer_profile_path(jogador.streamer_profile.id)
      expect(page).to have_content 'Perfil de Streamer criado com sucesso!'
      expect(page).to have_content 'Descrição Jovem de 22 anos sem ter o que fazer da vida e fica fazendo live na internet'
      have_css("img[src*='https://www.facebook.com/fulano/']")
      have_css("img[src*='https://twitter.com/fulano/']")
      have_css("img[src*='https://www.instagram.com/fulano/']")
      expect(page).to have_link 'https://www.facebook.com/fulano/'
      expect(page).to have_link 'https://twitter.com/fulano/'
      expect(page).to have_link 'https://www.instagram.com/fulano/'
    end
  end
end
