require 'rails_helper'

describe 'admin management streamer' do
  it 'can use link with login' do
    admin = create(:admin)
    login_as admin, scope: :admin

    visit root_path
    click_on 'Área do administrador'
    click_on 'Conteúdos'

    expect(page).to have_link('Ver Streamers', href: streamer_profiles_path)
  end

  it 'can view all streamers' do
    streamers_profiles = create_list(:streamer_profile, 3)

    login_as create(:admin), scope: :admin
    visit root_path
    click_on 'Área do administrador'
    click_on 'Conteúdos'
    click_on 'Ver Streamers'

    expect(current_path).to eq(streamer_profiles_path)
    streamers_profiles.each do |streamer_profile|
      expect(page).to have_link(streamer_profile.name, href: streamer_profile_path(streamer_profile))
      expect(page).to have_content('Ativo')
    end
    expect(page).to_not have_content('Não existem streamers cadastrados na plataforma')
  end

  it 'can view no there streamers' do
    admin = create(:admin)

    login_as admin, scope: :admin
    visit root_path
    click_on 'Área do administrador'
    click_on 'Conteúdos'
    click_on 'Ver Streamers'

    expect(current_path).to eq(streamer_profiles_path)
    expect(page).to have_content('Não existem streamers cadastrados na plataforma')
  end

  it 'can view link for disable a streamer' do
    admin = create(:admin)
    streamer_profile = create(:streamer_profile)

    login_as admin, scope: :admin
    visit root_path
    click_on 'Área do administrador'
    click_on 'Conteúdos'
    click_on 'Ver Streamers'
    click_on streamer_profile.name

    expect(current_path).to eq(streamer_profile_path(streamer_profile))
    expect(page).to have_link('Inativar', href: inactive_streamer_profile_path(streamer_profile))
  end
  it 'can disable a streamer' do
    admin = create(:admin)
    streamer_profile = create(:streamer_profile)

    login_as admin, scope: :admin
    visit root_path
    click_on 'Área do administrador'
    click_on 'Conteúdos'
    click_on 'Ver Streamers'
    click_on streamer_profile.name
    click_on 'Inativar'

    streamer_profile.reload
    expect(current_path).to eq streamer_profile_path(streamer_profile)
    expect(page).to have_content 'Streamer inativado com sucesso!'
    expect(streamer_profile.inactive?).to be true
    expect(page).to have_content 'Inativo'
    expect(page).to_not have_link 'Inativar'
    expect(page).to have_link 'Ativar'
  end

  it 'can view link for active a streamer' do
    admin = create(:admin)
    streamer_profile = create(:streamer_profile, status: 'inactive')

    login_as admin, scope: :admin
    visit root_path
    click_on 'Área do administrador'
    click_on 'Conteúdos'
    click_on 'Ver Streamers'
    click_on streamer_profile.name

    expect(current_path).to eq(streamer_profile_path(streamer_profile))
    expect(page).to have_link('Ativar', href: active_streamer_profile_path(streamer_profile))
    expect(page).to_not have_link('Inativar', href: inactive_streamer_profile_path(streamer_profile))
  end

  it 'can active a streamer' do
    admin = create(:admin)
    streamer_profile = create(:streamer_profile, status: 'inactive')

    login_as admin, scope: :admin
    visit root_path
    click_on 'Área do administrador'
    click_on 'Conteúdos'
    click_on 'Ver Streamers'
    click_on streamer_profile.name
    click_on 'Ativar'

    streamer_profile.reload
    expect(current_path).to eq streamer_profile_path(streamer_profile)
    expect(page).to have_content 'Streamer ativado com sucesso!'
    expect(streamer_profile.active?).to be true
    expect(page).to have_content 'Ativo'
    expect(page).to_not have_link 'Ativar'
    expect(page).to have_link 'Inativa'
  end

  it 'cannot active without login as admin' do
    streamer_profile = create(:streamer_profile, status: 'active')

    login_as streamer_profile.streamer, scope: :streamer
    visit root_path
    click_on streamer_profile.name
    click_on 'Meu Perfil'

    expect(current_path).to eq(streamer_profile_path(streamer_profile))
    expect(page).to_not have_link('Ativar', href: active_streamer_profile_path(streamer_profile))
  end

  it 'cannot inactive without login as admin' do
    streamer_profile = create(:streamer_profile, status: 'inactive')

    login_as streamer_profile.streamer, scope: :streamer
    visit root_path
    click_on streamer_profile.name
    click_on 'Meu Perfil'

    expect(current_path).to eq(streamer_profile_path(streamer_profile))
    expect(page).to_not have_link('Inativar', href: inactive_streamer_profile_path(streamer_profile))
  end
end
