require 'rails_helper'

describe 'games' do
  context 'Admin register games:' do
    it 'successfully' do
      admin = create(:admin)
      create(:game_category, name: 'Sandbox')
      create(:game_category, name: 'Sobrevivência')
      create(:game_category, name: 'Ação')

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Registrar novo jogo'
      fill_in 'Nome', with: 'Minecraft'
      select 'Sandbox', from: 'Categorias'
      select 'Sobrevivência', from: 'Categorias'
      click_on 'Registrar novo jogo'

      expect(page).to have_content('Nome: Minecraft')
      expect(page).to have_content('Categorias: Sandbox, Sobrevivência')
      expect(page).to have_content("Adicionado em #{Time.zone.now.to_date}, por #{admin.email}")
      expect(Game.count).to eq(1)
    end
  end
end