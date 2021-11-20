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
      click_on 'Registrar novo jogo'
      fill_in 'Nome', with: 'Minecraft'
      select 'Sobrevivência', from: 'Categorias'
      select 'Sandbox', from: 'Categorias'
      click_on 'Registrar novo jogo'

      expect(page).to have_content('Nome: Minecraft')
      expect(page).to have_content('Categorias: Sandbox, Sobrevivência')
      expect(page).to have_content("Adicionado em #{Time.zone.now.to_date}, por #{admin.email}")
      expect(Game.count).to eq(1)
    end
    it 'unsuccessfully - tried to create a repeated game' do
      admin = create(:admin)
      game_category = create(:game_category)
      Game.create!(name: 'Final Fantasy XII - The Zodiac Age', admin: admin,
                  creation_date: Time.zone.now.to_date, game_categories: [game_category])

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Registrar novo jogo'
      fill_in 'Nome', with: 'Final Fantasy XII - The Zodiac Age'
      click_on 'Registrar novo jogo'

      expect(page).to have_content('Nome já está em uso')
      expect(Game.count).to eq(1)
    end
    it 'unsuccessfully - tried to create a blank game' do
      admin = create(:admin)

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Registrar novo jogo'
      click_on 'Registrar novo jogo'

      expect(page).to have_content('Nome não pode ficar em branco')
      expect(page).to have_content('Categorias não pode ficar em branco')
      expect(Game.count).to eq(0)
    end
  end
  context 'Admin views games:' do
    it 'successfully' do
      admin = create(:admin)
      game_category = create(:game_category)
      Game.create!(name: 'Final Fantasy XII - The Zodiac Age', admin: admin,
                  creation_date: Time.zone.now.to_date, game_categories: [game_category])
      Game.create!(name: 'TLOZ - Breath of the Wild', admin: admin,
                  creation_date: Time.zone.now.to_date, game_categories: [game_category])            

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'

      expect(page).to have_content('Nome: TLOZ - Breath of the Wild')
      expect(page).to have_content('Final Fantasy XII - The Zodiac Age')

    end
    it 'and there are no games registered' do
      admin = create(:admin)

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'

      expect(page).to have_content('Nenhum jogo registrado.')
    end
  end
end