require 'rails_helper'

describe 'games' do
  context 'Admin register games:' do
    it 'successfully' do
      admin = create(:admin)
      create(:game_category, name: 'Ação')
      create(:game_category, name: 'Sobrevivência')
      create(:game_category, name: 'Sandbox')

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Jogos'
      fill_in 'Nome', with: 'Minecraft'
      select 'Sobrevivência', from: 'Categorias'
      select 'Sandbox', from: 'Categorias'
      click_on 'Registrar Jogo'

      expect(page).to have_content('Minecraft')
      expect(page).to have_content('Sandbox, Sobrevivência')
      expect(page).to have_content(I18n.l(Date.current))
      expect(page).to have_content(admin.email)
      expect(Game.count).to eq(1)
    end
    it 'unsuccessfully - tried to create a repeated game' do
      admin = create(:admin)
      create(:game, name: 'Final Fantasy XII - The Zodiac Age')

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Jogos'
      fill_in 'Nome', with: 'Final Fantasy XII - The Zodiac Age'
      click_on 'Registrar Jogo'

      expect(page).to have_content('Nome já está em uso')
      expect(Game.count).to eq(1)
    end
    it 'unsuccessfully - tried to create a blank game' do
      admin = create(:admin)

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Jogos'
      click_on 'Registrar Jogo'

      expect(page).to have_content('Nome não pode ficar em branco')
      expect(page).to have_content('Categorias não pode ficar em branco')
      expect(Game.count).to eq(0)
    end
  end
  context 'Admin views games:' do
    it 'successfully' do
      admin = create(:admin)
      create(:game, name: 'Final Fantasy XII - The Zodiac Age')
      create(:game, name: 'TLOZ - Breath of the Wild')

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Conteúdos'
      click_on 'Ver Jogos'

      expect(page).to have_content('TLOZ - Breath of the Wild')
      expect(page).to have_content('Final Fantasy XII - The Zodiac Age')
    end
    it 'and there are no games registered' do
      admin = create(:admin)

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Conteúdos'
      click_on 'Ver Jogos'

      expect(page).to have_content('Nenhum jogo registrado.')
    end
  end
end
