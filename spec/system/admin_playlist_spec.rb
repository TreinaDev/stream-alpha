require 'rails_helper'

describe 'Admin' do
  context 'successfully' do
    it 'can view link to create playlist' do
      admin = create(:admin)

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'

      expect(page).to have_link('Registrar nova playlist', href: new_playlist_path)
    end

    it 'creates playlist' do
      admin = create(:admin)

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Registrar nova playlist'
      fill_in 'Nome', with: 'Casual Gamers'
      fill_in 'Descrição', with: 'Encontre streamers que jogam apenas para se divertir.'
      attach_file 'Capa', Rails.root.join('spec/support/assets/gary-bendig-unsplash.jpg')
      click_on 'Enviar Playlist'

      expect(current_path).to eq playlist_path(1)
      expect(page).to have_content 'Playlist criada com sucesso!'
      expect(page).to have_content 'Nome: Casual Gamers'
      expect(page).to have_content 'Descrição: Encontre streamers que jogam apenas para se divertir.'
      expect(page).to have_css "img[src*='gary-bendig-unsplash.jpg']"
    end
  end

  context 'unsuccessfully' do
    it 'creates playlist with empty fields' do
      admin = create(:admin)

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Registrar nova playlist'
      click_on 'Enviar Playlist'

      expect(current_path).to eq playlists_path
      expect(page).to have_content('Erro ao criar Playlist!')
      expect(page).to have_content('Nome não pode ficar em branco')
      expect(page).to have_content('Descrição não pode ficar em branco')
    end
  end
end
