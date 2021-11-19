require 'rails_helper'

describe 'Admin register ' do
  context "a streamer's video plan" do
    it 'but see the registration form before' do
      admin = create(:admin)

      visit root_path
      click_on 'Entrar como Administrador'
      fill_in 'Email', with: admin.email
      fill_in 'Password', with: admin.password
      click_on 'Log in'
      click_on 'Área do administrador'
      click_on 'Cadastrar Plano'

      expect(page).to have_content('Insira as informações do plano que deseja cadastrar')
    end
  end 
end