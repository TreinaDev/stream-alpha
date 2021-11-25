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
    check 'Avulso'
    fill_in 'Preço', with: 50
    fill_in 'Link', with: 'https://vimeo.com/546542asffdmind56465craft'
    click_on 'Enviar'
    
    expect(page).to have_content('Video cadastrado com sucesso!')
    expect(page).to have_content('Nome: Jogando Mind Craft')
    expect(page).to have_content('Descrição: Jogador irado, joga demais!!')
    expect(page).to have_content('Avulso: Sim')
    expect(page).to have_content('Preço: R$ 50')
    expect(page).to have_link('Comprar')
    expect(page).to have_link('Video', href: 'https://vimeo.com/546542asffdmind56465craft')
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
  end

  it 'and don´t see the button if isn´t streamer' do
    visit root_path

    expect(page).not_to have_link('Cadastrar Video', href: new_video_path)
  end
end
