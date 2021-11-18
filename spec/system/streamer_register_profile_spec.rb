require 'rails_helper'

describe 'Streamer log in' do
  context 'and register profile' do
    it 'and fill profile' do
      streamer = create(:streamer)

      visit root_path
      click_on 'Entrar como Streamer'
      fill_in 'Email', with: streamer.email
      fill_in 'Senha', with: streamer.password
      click_on 'Entrar'
      fill_in 'Nome', with: 'Fulano'
      fill_in 'Descrição', with: 'Jovem de 22 anos sem ter o que fazer da vida e fica fazendo live na internet'
      fill_in 'URL do Facebook', with: 'https://www.facebook.com/fulano/'
      fill_in 'URL do Instagram', with: 'https://twitter.com/fulano/'
      fill_in 'URL do Twitter', with: 'https://www.instagram.com/fulano/'
      click_on 'Criar Perfil de Streamer'

      expect(current_path).to eq streamer_profile_path(streamer.streamer_profile.id)
      expect(page).to have_content 'Perfil de Streamer criado com sucesso!'
      expect(page).to have_content 'Descrição Jovem de 22 anos sem ter o que fazer da vida ' \
                                   'e fica fazendo live na internet'
      have_css("img[src*='https://www.facebook.com/fulano/']")
      have_css("img[src*='https://twitter.com/fulano/']")
      have_css("img[src*='https://www.instagram.com/fulano/']")
      expect(page).to have_link 'https://www.facebook.com/fulano/'
      expect(page).to have_link 'https://twitter.com/fulano/'
      expect(page).to have_link 'https://www.instagram.com/fulano/'
    end

    it 'and fill wrong' do
      streamer = create(:streamer)

      visit root_path
      click_on 'Entrar como Streamer'
      fill_in 'Email', with: streamer.email
      fill_in 'Senha', with: streamer.password
      click_on 'Entrar'
      fill_in 'Nome', with: ''
      fill_in 'Descrição', with: ''
      fill_in 'URL do Facebook', with: 'https://www.facebook.com/fulano/'
      fill_in 'URL do Instagram', with: 'https://twitter.com/fulano/'
      fill_in 'URL do Twitter', with: 'https://www.instagram.com/fulano/'
      click_on 'Criar Perfil de Streamer'

      expect(current_path).to eq streamer_profiles_path
      expect(page).to have_content('Nome não pode ficar em branco')
      expect(page).to have_content('Descrição não pode ficar em branco')
    end
  end
  context 'and profile already exists' do
    it 'and is redirected to home page' do
      streamer = create(:streamer)
      create(:streamer_profile, streamer: streamer)

      visit root_path
      click_on 'Entrar como Streamer'
      fill_in 'Email', with: streamer.email
      fill_in 'Senha', with: streamer.password
      click_on 'Entrar'

      expect(current_path).to eq root_path
      expect(page).to have_link('Meu Perfil', href: streamer_profile_path(streamer.streamer_profile.id))
    end

    it 'and click on the link to edit profile' do
      streamer = create(:streamer)
      profile = create(:streamer_profile, streamer: streamer)

      visit root_path
      click_on 'Entrar como Streamer'
      fill_in 'Email', with: streamer.email
      fill_in 'Senha', with: streamer.password
      click_on 'Entrar'
      click_on 'Meu Perfil'
      click_on 'Editar Perfil'

      expect(current_path).to eq edit_streamer_profile_path(profile)
      expect(page).to have_content('Insira as informações que deseja atualizar!')
    end

    it 'and edit profile' do
      streamer = create(:streamer)
      profile = create(:streamer_profile, streamer: streamer)

      visit root_path
      click_on 'Entrar como Streamer'
      fill_in 'Email', with: streamer.email
      fill_in 'Senha', with: streamer.password
      click_on 'Entrar'
      click_on 'Meu Perfil'
      click_on 'Editar Perfil'
      fill_in 'Descrição', with: 'Faço gameplays maneiras'
      fill_in 'URL do Instagram', with: 'https://www.instagram.com/alanzoka/'
      click_on 'Atualizar Perfil de Streamer'

      expect(page).to have_content('Perfil atualizado com sucesso!')
    end
  end
end
