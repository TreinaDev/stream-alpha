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
    game = create(:game, name: 'Megaman X4')

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

    expect(page).to have_content('Video cadastrado com sucesso!')
    expect(page).to have_css('iframe[src*="https://player.vimeo.com/video/613710178?autoplay=1&background=0"]')
    expect(page).to have_content('Jogando Mind Craft')
    expect(page).to have_content('Descrição: Jogador irado, joga demais!!')
    expect(page).to have_content('Megaman X4')
    expect(page).to have_content("Categorias: #{game.game_categories_list_as_string}")
    expect(page).to have_content('Status: Pendente')
    expect(page).to have_content('Avulso: Sim')
    expect(page).to have_content('Preço: R$ 50')
    expect(page).to_not have_link('Comprar Video', href: payment_video_path(1))
    expect(page).to_not have_link('Video', href: 'https://vimeo.com/613710178')
  end

  it 'and has no price if loose is not checked' do
    client = create(:client)
    create(:video)
    login_as client, scope: :client

    visit root_path
    click_on 'Ver todos os videos avulsos'
    click_on 'Jogando Mind Craft'

    expect(page).to have_content('Jogando Mind Craft')
    expect(page).to have_content('Descrição: Jogador irado, joga demais!!')
    expect(page).to have_content('Avulso: Não')
    expect(page).not_to have_content('Preço: R$ 9')
    expect(page).not_to have_link('Comprar Video')
  end

  it 'without fill fields' do
    streamer = create(:streamer)
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

  it 'then see other validations' do
    streamer = create(:streamer)
    login_as streamer, scope: :streamer

    visit new_video_path
    fill_in 'https://vimeo.com/', with: '0123456789'
    click_on 'Enviar'

    expect(current_path).to have_content('/videos')
    expect(page).to have_content('Erro ao criar Vídeo!')
    expect(page).to have_content('Link é muito longo (máximo: 9 caracteres)')
  end

  it 'but link is unique' do
    streamer = create(:streamer)
    create(:video, link: '123456789')
    login_as streamer, scope: :streamer

    visit new_video_path
    fill_in 'https://vimeo.com/', with: '123456789'
    click_on 'Enviar'

    expect(current_path).to have_content('/videos')
    expect(page).to have_content('Erro ao criar Vídeo!')
    expect(page).to have_content('Link já está em uso')
  end

  it 'and don´t see the button if isn´t streamer' do
    visit root_path

    expect(page).not_to have_link('Cadastrar Video', href: new_video_path)
  end
end
