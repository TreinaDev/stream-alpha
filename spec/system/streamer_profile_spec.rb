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
      attach_file 'Foto do Perfil', Rails.root.join('spec/support/assets/gary-bendig-6GMq7AGxNbE-unsplash.jpg')
      fill_in 'Descrição', with: 'Jovem de 22 anos sem ter o que fazer da vida e fica fazendo live na internet'
      fill_in 'URL do Facebook', with: 'https://www.facebook.com/fulano/'
      fill_in 'URL do Instagram', with: 'https://twitter.com/fulano/'
      fill_in 'URL do Twitter', with: 'https://www.instagram.com/fulano/'
      click_on 'Criar Perfil de streamer'

      expect(current_path).to eq streamer_profile_path(streamer.streamer_profile)
      expect(page).to have_content 'Perfil de streamer criado com sucesso!'
      expect(page).to have_content 'Descrição: Jovem de 22 anos sem ter o que fazer da vida ' \
                                   'e fica fazendo live na internet'
      expect(page).to have_css('img[src*="gary-bendig-6GMq7AGxNbE-unsplash.jpg"]')
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
      fill_in 'URL do Facebook', with: ''
      fill_in 'URL do Instagram', with: ''
      fill_in 'URL do Twitter', with: ''
      click_on 'Criar Perfil de streamer'

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
      create(:streamer_profile, streamer: streamer)

      visit root_path
      click_on 'Entrar como Streamer'
      fill_in 'Email', with: streamer.email
      fill_in 'Senha', with: streamer.password
      click_on 'Entrar'
      click_on 'Meu Perfil'
      click_on 'Editar Perfil'
      fill_in 'Descrição', with: 'Faço gameplays maneiras'
      fill_in 'URL do Instagram', with: 'https://www.instagram.com/alanzoka/'
      click_on 'Atualizar Perfil de streamer'

      expect(current_path).to eq streamer_profile_path(streamer.streamer_profile)
      expect(page).to have_content('Perfil atualizado com sucesso!')
      expect(page).to have_css('img[src*="streamer_photo' \
                               '-7cf2b2e4a6bf46ca28b45bc3a866a1a9bfca0a3de9ce12f59caf7da72bcf72b8.svg"]')
    end

    it 'and cant edit another streamer profile' do
      streamer = create(:streamer)
      streamer2 = create(:streamer)
      create(:streamer_profile, streamer: streamer)
      streamer_profile2 = create(:streamer_profile, streamer: streamer2)

      visit root_path
      click_on 'Entrar como Streamer'
      fill_in 'Email', with: streamer.email
      fill_in 'Senha', with: streamer.password
      click_on 'Entrar'
      visit edit_streamer_profile_path(streamer2.streamer_profile)

      expect(current_path).to eq root_path
      expect(page).to have_content 'Você só pode editar o seu ' \
                                   "#{I18n.t(:streamer_profile, scope: 'activerecord.models')}!"
      expect(page).to_not have_content streamer_profile2.name
      expect(page).to_not have_content streamer_profile2.description
      expect(page).to_not have_link streamer_profile2.facebook
      expect(page).to_not have_link streamer_profile2.twitter
      expect(page).to_not have_link streamer_profile2.instagram
    end
  end
end
