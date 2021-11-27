require 'rails_helper'

describe 'Streamer' do
  context 'successfully' do
    it 'can view link' do
      streamer = create(:streamer)
      create(:streamer_profile, streamer: streamer)

      login_as streamer, scope: :streamer
      visit root_path

      expect(page).to have_link('Cadastrar Vídeo', href: new_video_path)
    end

    it 'register a video' do
      streamer = create(:streamer)
      game = create(:game, name: 'Megaman X4')
      create(:streamer_profile, name: 'Solaire', streamer: streamer)

      login_as streamer, scope: :streamer
      visit root_path
      click_on 'Cadastrar Vídeo'
      fill_in 'Nome', with: 'Jogando Mind Craft'
      fill_in 'Descrição', with: 'Jogador irado, joga demais!!'
      check 'Avulso'
      fill_in 'Preço', with: 50
      fill_in 'https://vimeo.com/', with: '613710178'
      select 'Megaman X4', from: 'Jogo'
      click_on 'Enviar'

      expect(page).to have_content('Vídeo cadastrado com sucesso!')
      expect(page).to have_css('iframe[src*="https://player.vimeo.com/video/613710178?autoplay=1&background=0"]')
      expect(page).to have_content('Jogando Mind Craft')
      expect(page).to have_content("1 Visualização - #{I18n.l(Time.zone.now.to_date)}")
      expect(page).to have_content('Por: Solaire')
      expect(page).to have_content('Descrição: Jogador irado, joga demais!!')
      expect(page).to have_content('Megaman X4')
      expect(page).to have_content("Categorias: #{game.game_categories_list_as_string}")
      expect(page).to have_content('Status: Pendente')
      expect(page).to have_content('Avulso: Sim')
      expect(page).to have_content('Preço: R$ 50')
      expect(page).to_not have_link('Comprar Video', href: payment_video_path(1))
      expect(page).to_not have_link('Video', href: 'https://vimeo.com/613710178')
    end

    it 'doesnt see price on non-loose videos' do
      client = create(:client)
      streamer_profile = create(:streamer_profile, name: 'Solaire')
      video = create(:video, streamer: streamer_profile.streamer, visualization: 0, created_at: Time.zone.now)

      login_as client, scope: :client
      visit root_path
      click_on 'Ver todos os videos avulsos'
      click_on video.name

      expect(page).to have_content(video.name)
      expect(page).to have_content('Por: Solaire')
      expect(page).to have_content("1 Visualização - #{I18n.l(Time.zone.now.to_date)}")
      expect(page).to have_content('Descrição: Jogador irado, joga demais!!')
      expect(page).to have_content('Avulso: Não')
      expect(page).not_to have_content('Preço:')
      expect(page).not_to have_content('Preço: R$ 9')
      expect(page).not_to have_link('Comprar Video')
    end

    it 'see my videos page' do
      streamer_profile = create(:streamer_profile, name: 'Solaire')
      streamer_profile2 = create(:streamer_profile, name: 'Anti-Solaire')
      video1 = create(:video, name: 'Jogando Mind Craft', status: 'pending', streamer: streamer_profile.streamer)
      video2 = create(:video, name: 'Fifa 1988', status: 'pending', streamer: streamer_profile.streamer)
      video3 = create(:video, name: 'Grand theft auto crazy', status: 'approved', streamer: streamer_profile2.streamer)
      video4 = create(:video, name: 'Master yi insace mechanics', streamer: streamer_profile2.streamer)

      login_as streamer_profile.streamer, scope: :streamer
      visit root_path
      click_on 'Meus Vídeos'

      expect(current_path).to eq(my_videos_videos_path)
      expect(page).to have_content('Nome Jogo Categoria de Jogos Criado em')
      expect(page).to have_link('Jogando Mind Craft', href: video_path(video1))
      expect(page).to have_link('Fifa 1988', href: video_path(video2))
      expect(page).to_not have_link('Grand theft auto crazy', href: video_path(video3))
      expect(page).to_not have_link('Master yi insace mechanics', href: video_path(video4))
    end
  end

  context 'unsuccessfully' do
    it 'create video without filling fields' do
      streamer = create(:streamer)
      create(:streamer_profile, name: 'Solaire', streamer: streamer)

      login_as streamer, scope: :streamer
      visit new_video_path
      click_on 'Enviar'

      expect(current_path).to have_content('/videos')
      expect(page).to have_content('Erro ao criar Vídeo!')
      expect(page).to have_content('Jogo é obrigatório(a)')
      expect(page).to have_content('Nome não pode ficar em branco')
      expect(page).to have_content('Descrição não pode ficar em branco')
      expect(page).to have_content('Link não pode ficar em branco')
      expect(page).to have_content('Link não é um número')
      expect(page).to have_content('Link é muito curto (mínimo: 8 caracteres)')
    end

    it 'create, then see other validations' do
      streamer = create(:streamer)
      create(:streamer_profile, name: 'Solaire', streamer: streamer)

      login_as streamer, scope: :streamer
      visit new_video_path
      fill_in 'https://vimeo.com/', with: '0123456789'
      click_on 'Enviar'

      expect(current_path).to have_content('/videos')
      expect(page).to have_content('Erro ao criar Vídeo!')
      expect(page).to have_content('Link é muito longo (máximo: 9 caracteres)')
    end

    it 'create because the link is unique' do
      streamer = create(:streamer)
      create(:streamer_profile, name: 'Solaire', streamer: streamer)
      create(:video, link: '123456789')
      login_as streamer, scope: :streamer

      visit new_video_path
      fill_in 'https://vimeo.com/', with: '123456789'
      click_on 'Enviar'

      expect(current_path).to have_content('/videos')
      expect(page).to have_content('Erro ao criar Vídeo!')
      expect(page).to have_content('Link já está em uso')
    end

    it 'see the button if isn´t streamer' do
      visit root_path

      expect(page).not_to have_link('Cadastrar Video', href: new_video_path)
    end
  end
end
