require 'rails_helper'

describe 'Streamer login -' do
  context 'login:' do
    it 'without a streamer profile' do
      streamer = create(:streamer)

      visit root_path
      click_on 'Como Streamer'
      fill_in 'Email', with: streamer.email
      fill_in 'Senha', with: streamer.password
      within 'form' do
        click_on 'Entrar'
      end

      expect(current_path).to eq(new_streamer_profile_path)
      expect(page).to have_content 'Login efetuado com sucesso!'
      expect(page).to have_button 'Sair'
    end
  end
end
