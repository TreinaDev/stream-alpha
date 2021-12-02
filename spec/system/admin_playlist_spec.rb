require 'rails_helper'

describe 'Admin' do
  context 'successfully' do
    it 'can view link to create playlist' do
      admin = create(:admin)

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'

      expect(page).to have_link('Playlist', href: new_playlist_path)
    end

    it 'creates playlist' do
      video = create(:video, :approved, name: 'jogando fifa modo carreira')
      video2 = create(:video, :approved, name: 'jogando fifa na master league')
      video3 = create(:video, :approved, name: 'jogando Mind Craft')
      streamer = create(:streamer_profile, name: 'Yoda SL')
      streamer2 = create(:streamer_profile, name: 'Robo')
      admin = create(:admin)

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Playlist'
      fill_in 'Nome', with: 'Casual Gamers'
      fill_in 'Descrição', with: 'Encontre streamers que jogam apenas para se divertir.'
      attach_file 'Capa', Rails.root.join('spec/support/assets/gary-bendig-unsplash.jpg')
      select 'jogando fifa modo carreira', from: 'Videos'
      select 'jogando fifa na master league', from: 'Videos'
      select 'Yoda SL', from: 'Streamers'
      select 'Robo', from: 'Streamers'

      click_on 'Criar Playlist'

      expect(current_path).to eq playlist_path(1)
      expect(page).to have_content 'Playlist criada com sucesso!'
      expect(page).to have_content 'Nome: Casual Gamers'
      expect(page).to have_content 'Descrição: Encontre streamers que jogam apenas para se divertir.'
      expect(page).to have_link('jogando fifa modo carreira', href: video_path(video))
      expect(page).to have_link('jogando fifa na master league', href: video_path(video2))
      expect(page).to have_link('Yoda SL', href: streamer_profile_path(streamer))
      expect(page).to have_link('Robo', href: streamer_profile_path(streamer2))
      expect(page).to have_css "img[src*='gary-bendig-unsplash.jpg']"
      expect(page).to_not have_link('jogando Mind Craft', href: video_path(video3))
    end

    it 'can view playlists' do
      video = create(:video, :approved, name: 'jogando fifa modo carreira')
      video2 = create(:video, :approved, name: 'jogando fifa na master league')
      streamer_profile = create(:streamer_profile, name: 'Yoda SL')
      streamer_profile2 = create(:streamer_profile, name: 'Robo')
      playlist = create(:playlist, name: 'Casual Gamers', videos: [video, video2],
                                   streamers: [streamer_profile.streamer, streamer_profile2.streamer])
      admin = create(:admin)

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Conteúdos'
      click_on 'Ver Playlists'

      expect(current_path).to eq playlists_path
      expect(page).to have_content 'Casual Gamers'
      expect(page).to have_content 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, ' \
                                   'labore et dolore magna aliqua.'
      expect(page).to have_content I18n.l playlist.created_at.to_date
    end
  end

  it 'but theres no playlist' do
    admin = create(:admin)

    login_as admin, scope: :admin
    visit root_path
    click_on 'Área do administrador'
    click_on 'Conteúdos'
    click_on 'Ver Playlists'

    expect(current_path).to eq playlists_path
    expect(page).to have_content 'Nenhuma playlist registrada.'
  end

  context 'unsuccessfully' do
    it 'creates playlist with empty fields' do
      admin = create(:admin)
      create(:video, name: 'jogando fifa na master league')

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Playlist'
      click_on 'Criar Playlist'

      expect(current_path).to eq playlists_path
      expect(page).to have_content('Erro ao criar Playlist!')
      expect(page).to have_content('Nome não pode ficar em branco')
      expect(page).to have_content('Descrição não pode ficar em branco')
    end
  end
end
