require 'rails_helper'

describe 'admin approves registration of video' do
  it 'and view pending videos' do
    video1 = create(:video, name: 'Jogando Mind Craft', status: 'pending')
    video2 = create(:video, name: 'Fifa 1988', status: 'pending')
    video3 = create(:video, name: 'Grand theft auto crazy', status: 'approved')
    admin = create(:admin)
    login_as admin, scope: :admin

    visit root_path
    click_on 'Area Do Administrador'
    click_on 'Videos Pendentes'

    expect(page).to have_link('Jogando Mind Craft', href: video_path(video1))
    expect(page).to have_link('Fifa 1988', href: video_path(video2))
    expect(page).not_to have_link('Grand theft auto crazy', href: video_path(video3))
  end
end
