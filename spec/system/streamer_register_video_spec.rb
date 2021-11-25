require 'rails_helper'

describe 'streamer register a video' do
  it 'using link' do
    streamer = create(:streamer)

    login_as streamer, scope: :streamer
    visit root_path

    expect(page).to have_link('Cadastrar Vídeo', href: new_video_path)
  end

  it 'successfully' do
    streamer = create(:streamer)

    login_as streamer, scope: :streamer
    visit root_path
    click_on 'Cadastrar Vídeo'
    fill_in 'Nome', with: 'Jogando Mind Craft'
    fill_in 'Descrição', with: 'Jogador irado, joga demais!!'
    fill_in 'https://vimeo.com/', with: '613710178'
    click_on 'Enviar'

    expect(page).to have_content('Video cadastrado com sucesso!')
    expect(page).to have_css('iframe[src*="https://player.vimeo.com/video/613710178?autoplay=1&background=0"]')
    expect(page).to have_content('Jogando Mind Craft')
    expect(page).to have_content('Descrição: Jogador irado, joga demais!!')
    expect(page).to have_content('Status: Pendente')
    expect(page).to_not have_link('Comprar Video', href: payment_video_path(1))
  end

  it 'without fill fields' do
    streamer = create(:streamer)
    login_as streamer, scope: :streamer

    visit new_video_path
    click_on 'Enviar'

    expect(current_path).to have_content('/videos')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Link não pode ficar em branco')
    expect(page).to have_content('Link não é um número')
    expect(page).to have_content('Link é muito curto (mínimo: 8 caracteres)')
  end

  it 'then see other validations' do
    streamer = create(:streamer)
    login_as streamer, scope: :streamer

    visit new_video_path
    fill_in 'https://vimeo.com/', with: '0123456789'
    click_on 'Enviar'

    expect(current_path).to have_content('/videos')
    expect(page).to have_content('Link é muito longo (máximo: 9 caracteres)')
  end

  it 'and don´t see the button if isn´t streamer' do
    visit root_path

    expect(page).not_to have_link('Cadastrar Video', href: new_video_path)
  end
end
