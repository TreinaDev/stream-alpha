require 'rails_helper'

describe 'admin approves registration of video' do
  it 'and view pending videos' do
    video1 = create(:video, name: 'Jogando Mind Craft', status: 'pending')
    video2 = create(:video, name: 'Fifa 1988', status: 'pending')
    video3 = create(:video, name: 'Grand theft auto crazy', status: 'approved')
    video4 = create(:video, name: 'Master yi insace mechanics', status: 'refused',
                            feed_back: 'Não atende aos requisitos')

    admin = create(:admin)
    login_as admin, scope: :admin

    visit root_path
    click_on 'Área do administrador'
    click_on 'Ver Vídeos Pendentes'

    expect(page).to have_link('Jogando Mind Craft', href: video_path(video1))
    expect(page).to have_link('Fifa 1988', href: video_path(video2))
    expect(page).to_not have_link('Grand theft auto crazy', href: video_path(video3))
    expect(page).to_not have_link('Master yi insace mechanics', href: video_path(video4))
  end

  it 'and approves video' do
    streamer_profile = create(:streamer_profile, name: 'Solaire')
    video1 = create(:video, name: 'Jogando Mind Craft', status: 'pending', streamer: streamer_profile.streamer)
    admin = create(:admin)
    login_as admin, scope: :admin

    visit root_path
    click_on 'Área do administrador'
    click_on 'Ver Vídeos Pendentes'
    click_on 'Jogando Mind Craft'
    click_on 'Aprovar Vídeo'
    video1.reload

    expect(current_path).to eq(video_path(video1))
    expect(page).to have_content('Vídeo aprovado com sucesso!')
    expect(page).to have_link('Voltar', href: analysis_videos_path)
    expect(video1.status).to eq('approved')
    expect(page).to have_content('Status: Aprovado')
    expect(page).to_not have_content('Feedback:')
    expect(page).to_not have_link('Jogando Mind Craft', href: video_path(video1))
    expect(page).to_not have_link('Aprovar Vídeo')
    expect(page).to_not have_button('Recusar Vídeo')
  end
  it 'and approves a single video, registering it on pagapaga via API' do
    streamer_profile = create(:streamer_profile)
    video = create(:video, name: 'Ocarina of Time Any% WR', status: 'pending', streamer: streamer_profile.streamer)
    create(:price, video: video)
    admin = create(:admin)
    api_response = File.read(Rails.root.join('spec/support/apis/single_video_registration_201.json'))
    fake_response = double('faraday_response', status: 201, body: api_response)
    allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/products',
                                          { product: { name: video.name, type_of: 'single' } },
                                          { companyToken: Rails.configuration.payment_api['company_auth_token'] })
                                    .and_return(fake_response)

    login_as admin, scope: :admin
    visit root_path
    click_on 'Área do administrador'
    click_on 'Vídeos Pendentes'
    click_on 'Ocarina of Time Any% WR'
    click_on 'Aprovar'

    video.reload
    expect(current_path).to eq(video_path(video))
    expect(video.status).to eq('approved')
    expect(page).to have_content('Vídeo aprovado com sucesso!')
    expect(video.single_video_token).to eq('ncsSFYxlrW0fcHJKN5jj')
  end
  it 'and tries to approve a single video, but PagaPaga API is down' do
    streamer_profile = create(:streamer_profile)
    video = create(:video, name: 'Ocarina of Time Any% WR', status: 'pending', streamer: streamer_profile.streamer)
    create(:price, video: video)
    admin = create(:admin)
    fake_response = double('faraday_response', status: 500, body: nil)
    allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/products',
                                          { product: { name: video.name, type_of: 'single' } },
                                          { companyToken: Rails.configuration.payment_api['company_auth_token'] })
                                    .and_return(fake_response)

    login_as admin, scope: :admin
    visit root_path
    click_on 'Área do administrador'
    click_on 'Vídeos Pendentes'
    click_on 'Ocarina of Time Any% WR'
    click_on 'Aprovar'

    video.reload
    expect(current_path).to eq(video_path(video))
    expect(video.status).to eq('pending')
    expect(page).to have_content('Falha na integração com a plataforma Pagapaga. Tente novamente')
    expect(video.single_video_token).to eq(nil)
  end
  it 'and refused video' do
    streamer_profile = create(:streamer_profile, name: 'Solaire')
    video1 = create(:video, name: 'Jogando Mind Craft', status: 'pending', streamer: streamer_profile.streamer)
    admin = create(:admin)
    login_as admin, scope: :admin

    visit root_path
    click_on 'Área do administrador'
    click_on 'Ver Vídeos Pendentes'
    click_on 'Jogando Mind Craft'
    fill_in 'Retorne um feedback para o streamer', with: 'Podia ser melhor...'
    click_on 'Recusar Vídeo'

    expect(current_path).to eq(video_path(video1))
    expect(page).to have_content('Vídeo recusado com sucesso!')
    expect(page).to have_content('Status: Recusado')
    expect(page).to have_content('Feedback: Podia ser melhor...')
    expect(page).to_not have_link('Aprovar Vídeo')
    expect(page).to_not have_button('Recusar Vídeo')
    expect(page).to_not have_content('Retorne um feedback para o streamer:')
  end

  it 'and refused video with feedback' do
    streamer_profile = create(:streamer_profile, name: 'Solaire')
    video1 = create(:video, name: 'Jogando Mind Craft', status: 'pending', streamer: streamer_profile.streamer)
    admin = create(:admin)
    login_as admin, scope: :admin

    visit root_path
    click_on 'Área do administrador'
    click_on 'Ver Vídeos Pendentes'
    click_on 'Jogando Mind Craft'
    fill_in 'Retorne um feedback para o streamer:',	with: 'o vídeo não se enquadra no requisitos preestabelecidos'
    click_on 'Recusar Vídeo'

    video1.reload
    expect(video1.status).to eq('refused')
    expect(video1.feed_back).to eq('o vídeo não se enquadra no requisitos preestabelecidos')
    expect(current_path).to eq(video_path(video1))
    expect(page).to have_content('Vídeo recusado com sucesso!')
    expect(page).to have_content('Status: Recusado')
    expect(page).to have_content('Feedback: o vídeo não se enquadra no requisitos preestabelecidos')
    expect(page).to_not have_link('Aprovar Vídeo')
    expect(page).to_not have_button('Recusar Vídeo')
  end

  it 'and tried to refused without filling feedback' do
    streamer_profile = create(:streamer_profile, name: 'Solaire')
    video1 = create(:video, name: 'Jogando Mind Craft', status: 'pending', streamer: streamer_profile.streamer)
    admin = create(:admin)
    login_as admin, scope: :admin

    visit root_path
    click_on 'Área do administrador'
    click_on 'Ver Vídeos Pendentes'
    click_on 'Jogando Mind Craft'
    click_on 'Recusar Vídeo'

    expect(current_path).to eq(refuse_video_path(video1))
    expect(page).to have_content('Erro ao recusar Vídeo!')
    expect(page).to have_link('Aprovar Vídeo')
    expect(page).to have_content('Feedback não pode ficar em branco')
    expect(page).to have_button('Recusar Vídeo')
    expect(page).to have_content('Status: Pendente')
  end
end
