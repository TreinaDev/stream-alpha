require 'rails_helper'

describe 'admin content' do
  it 'can view links' do
    admin = create(:admin)

    login_as admin, scope: :admin
    visit root_path
    click_on 'Área do administrador'
    click_on 'Conteúdos'

    expect(current_path).to eq(admin_contents_admins_path)
    expect(page).to have_link('Dashboard', href: admin_area_admins_path)
    expect(page).to have_link('Conteúdos', href: admin_contents_admins_path)
    expect(page).to have_link('Ver Streamer', href: streamer_profiles_path)
    expect(page).to have_link('Ver Vídeos Pendentes', href: analysis_videos_path)
    expect(page).to have_link('Ver Planos de Assinatura', href: plans_path)
    expect(page).to have_link('Ver Playlists', href: playlists_path)
    expect(page).to have_link('Ver Categoria de Jogos', href: game_categories_path)
    expect(page).to have_link('Ver Jogos', href: games_path)
  end
  it 'can view game categories' do
    admin = create(:admin)
    create(:game_category, name: 'Arcade')
    create(:game_category, name: 'Ação')
    create(:game_category, name: 'Luta')

    login_as admin, scope: :admin
    visit root_path
    click_on 'Área do administrador'
    click_on 'Conteúdos'

    expect(current_path).to eq(admin_contents_admins_path)
    expect(page).to have_content('Arcade')
    expect(page).to have_content('Ação')
    expect(page).to have_content('Luta')
  end
  it 'can view lastest videos submitted' do
    admin = create(:admin)
    video1 = create(:video)
    video2 = create(:video)

    login_as admin, scope: :admin
    visit root_path
    click_on 'Área do administrador'
    click_on 'Conteúdos'

    expect(current_path).to eq(admin_contents_admins_path)
    expect(page).to have_content(video1.name)
    expect(page).to have_content(video1.streamer.email)
    expect(page).to have_content(video1.game.name)
    expect(page).to have_content(I18n.l(video1.created_at.to_date))
    expect(page).to have_content(video2.name)
    expect(page).to have_content(video2.streamer.email)
    expect(page).to have_content(video2.game.name)
    expect(page).to have_content(I18n.l(video2.created_at.to_date))
  end
  it 'can view statistics' do
    admin = create(:admin)
    create_list(:video, 5, status: 'approved')
    create_list(:video, 3)

    login_as admin, scope: :admin
    visit root_path
    click_on 'Área do administrador'
    click_on 'Conteúdos'

    expect(current_path).to eq(admin_contents_admins_path)
    expect(page).to have_content(/3/)
    expect(page).to have_content(/5/)
    expect(page).to have_content(/0/)
  end
end
