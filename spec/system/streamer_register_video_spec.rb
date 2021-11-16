require 'rails_helper'

describe 'streamer register a video' do
  it 'using link' do
    streamer = Streamer.new(email: 'streamer@domain.com', password: '123456')

    login_as streamer, scope: :streamer

    visit root_path

    expect(page).to have_link('Cadastrar Video', href: new_video_path)
  end

  it 'successfully' do
    streamer = create(:streamer)
    login_as streamer, scope: :streamer

    visit root_path
    click_on 'Cadastrar Video'
    fill_in 'Nome', with: 'Jogando Mind Craft'
    fill_in 'Descrição', with: 'Jogador irado, joga demais!!'
    fill_in 'Link do video', with: 'https://vimeo.com/546542asffdmind56465craft'
    click_on 'Enviar'

    expect(page).to have_content('Nome: Jogando Mind Craft')
    expect(page).to have_content('Video cadastrado com sucesso!')
    expect(page).to have_content('Descrição: Jogador irado, joga demais!!')
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
end
