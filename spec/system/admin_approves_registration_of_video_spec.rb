require 'rails_helper'

describe 'admin approves registration of video' do
  it 'and view pending videos' do
    video1 = create(:video, name: 'Jogando Mind Craft', status: 'pending')
    video2 = create(:video, name: 'Fifa 1988', status: 'pending')
    video3 = create(:video, name: 'Grand theft auto crazy', status: 'approved')
    admin = create(:admin)
    login_as admin, scope: :admin

    visit root_path
    click_on 'Área do administrador'
    click_on 'Videos Pendentes'

    expect(page).to have_link('Jogando Mind Craft', href: video_path(video1))
    expect(page).to have_link('Fifa 1988', href: video_path(video2))
    expect(page).not_to have_link('Grand theft auto crazy', href: video_path(video3))
  end

  it 'and approves video' do
    video1 = create(:video, name: 'Jogando Mind Craft', status: 'pending')
    admin = create(:admin)
    login_as admin, scope: :admin

    visit root_path
    click_on 'Área do administrador'
    click_on 'Videos Pendentes'
    click_on 'Jogando Mind Craft'
    click_on 'Aprovar'

    video1.reload
    expect(current_path).to eq(video_path(video1))
    expect(video1.status).to eq('approved')
    expect(page).to have_content('Video aprovado com sucesso')
    expect(page).to have_link('Voltar', href: analysis_videos_path)
    expect(page).not_to have_link('Jogando Mind Craft', href: video_path(video1))
    expect(page).not_to have_link('Aprovar')
    expect(page).not_to have_link('Rejeitar')
  end

  it 'and refused video' do
    video1 = create(:video, name: 'Jogando Mind Craft', status: 'pending')
    admin = create(:admin)
    login_as admin, scope: :admin

    visit root_path
    click_on 'Área do administrador'
    click_on 'Videos Pendentes'
    click_on 'Jogando Mind Craft'
    click_on 'Rejeitar'

    video1.reload
    expect(current_path).to eq(refuse_button_video_path(video1))
    expect(video1.status).to eq('refused')
    expect(page).to have_content('Retorne um feedback para o streamer:')
    expect(page).to have_button('Enviar')
    expect(page).not_to have_link('Aprovar')
    expect(page).not_to have_link('Rejeitar')
  end
  it 'and refused video with feedback' do
    video1 = create(:video, name: 'Jogando Mind Craft', status: 'pending')
    admin = create(:admin)
    login_as admin, scope: :admin

    visit root_path
    click_on 'Área do administrador'
    click_on 'Videos Pendentes'
    click_on 'Jogando Mind Craft'
    click_on 'Rejeitar'
    fill_in 'Retorne um feedback para o streamer:',	with: 'o vídeo não se enquadra no requisitos preestabelecidos'
    click_on 'Enviar'
    video1.reload

    expect(video1.feed_back).to eq('o vídeo não se enquadra no requisitos preestabelecidos')
    expect(current_path).to eq(video_path(video1))
    expect(video1.status).to eq('refused')
    expect(page).to have_content('Feedback: o vídeo não se enquadra no requisitos preestabelecidos')
    expect(page).not_to have_link('Aprovar')
    expect(page).not_to have_link('Rejeitar')
    expect(page).not_to have_button('Enviar')
  end
end
