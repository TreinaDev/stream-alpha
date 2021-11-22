require 'rails_helper'

describe 'admin management streamer' do
  it 'can use link with login' do
    login_as create(:admin), scope: :admin

    visit admin_area_admins_path

    expect(page).to have_link('Ver Streamers', href: streamer_profiles_path)
  end
  it 'can view all streamers' do
    streamers = create_list(:streamer_profile, 3)

    login_as create(:admin), scope: :admin

    visit admin_area_admins_path
    click_on 'Ver Streamers'
    
    expect(current_path).to eq(streamer_profiles_path) 
    streamers.each do |streamer|
      expect(page).to have_link(streamer.name, href: streamer_profile_path(streamer))
      expect(page).to have_content('Ativo')
    end  
    expect(page).to_not have_content('Não existem streamers cadastrados na plataforma')
  end
  it 'can view no there streamers' do
    login_as create(:admin), scope: :admin

    visit admin_area_admins_path
    click_on 'Ver Streamers'
    
    expect(current_path).to eq(streamer_profiles_path) 
    expect(page).to have_content('Não existem streamers cadastrados na plataforma')
  end
  it 'can view link for disable a streamer' do
    streamer = create(:streamer_profile)

    login_as create(:admin), scope: :admin

    visit admin_area_admins_path
    click_on 'Ver Streamers'
    click_on streamer.name

    expect(current_path).to eq(streamer_profile_path(streamer)) 
    expect(page).to have_link('Inativar', href: inactive_streamer_profile_path(streamer))
  end
  it 'can disable a streamer' do
    streamer = create(:streamer_profile)

    login_as create(:admin), scope: :admin

    visit streamer_profile_path(streamer)
    click_on 'Inativar'

    streamer.reload
    expect(current_path).to eq streamer_profile_path(streamer) 
    expect(streamer.inactive?).to be true
    expect(page).to have_content 'Streamer inativado com sucesso!'
    expect(page).to have_content 'Inativo'
    expect(page).to_not have_link 'Inativar'
    expect(page).to have_link 'Ativar'
  end
  it 'can view link for active a streamer' do
    streamer = create(:streamer_profile, status: 'inactive')

    login_as create(:admin), scope: :admin

    visit admin_area_admins_path
    click_on 'Ver Streamers'
    click_on streamer.name

    expect(current_path).to eq(streamer_profile_path(streamer)) 
    expect(page).to have_link('Ativar', href: active_streamer_profile_path(streamer))
    expect(page).to_not have_link('Inativar', href: inactive_streamer_profile_path(streamer))
  end
  it 'can active a streamer' do
    streamer = create(:streamer_profile, status: 'inactive')

    login_as create(:admin), scope: :admin

    visit streamer_profile_path(streamer)
    click_on 'Ativar'

    streamer.reload
    expect(current_path).to eq streamer_profile_path(streamer) 
    expect(streamer.active?).to be true
    expect(page).to have_content 'Streamer ativado com sucesso!'
    expect(page).to have_content 'Ativo'
    expect(page).to_not have_link 'Ativar'
    expect(page).to have_link 'Inativa'
  end
  it 'cannot active without login as admin' do
    streamer = create(:streamer_profile, status: 'inactive')

    login_as streamer.streamer, scope: :streamer

    visit streamer_profile_path(streamer)

    expect(page).to_not have_link('Inativar', href: inactive_streamer_profile_path(streamer))
  end
  it 'cannot inactive without login as admin' do
    streamer = create(:streamer_profile, status: 'inactive')

    login_as streamer.streamer, scope: :streamer

    visit streamer_profile_path(streamer)

    expect(page).to_not have_link('Inativar', href: inactive_streamer_profile_path(streamer))
  end
end
