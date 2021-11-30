require 'rails_helper'

describe 'Streamer registration and login -' do
  context 'registration:' do
    it 'successfully' do
      visit root_path
      click_on 'Inscreva-se'
      click_on 'Como novo streamer'
      fill_in 'Email', with: 'streamer@user.com'
      fill_in 'Senha', with: '123456789'
      fill_in 'Confirme sua senha', with: '123456789'
      click_on 'Cadastrar'

      expect(current_path).to eq(new_streamer_profile_path)
      expect(page).to have_content 'Login efetuado com sucesso. Se não foi autorizado, ' \
                                   'a confirmação será enviada por e-mail.'
      expect(page).to have_content 'streamer@user.com'
    end
  end

  context 'login:' do
    it 'without a streamer profile' do
      streamer = create(:streamer)

      visit root_path
      click_on 'Como streamer'
      fill_in 'Email', with: streamer.email
      fill_in 'Senha', with: streamer.password
      within 'form' do
        click_on 'Entrar'
      end

      expect(current_path).to eq(new_streamer_profile_path)
      expect(page).to have_content 'Login efetuado com sucesso!'
      expect(page).to have_content streamer.email
    end
  end
end
