require 'rails_helper'

describe 'game categories' do
  context 'Admin register game categories:' do
    it 'successfully' do
      admin = create(:admin)

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Registrar nova categoria de jogos'
      fill_in 'Nome', with: 'Ação'
      click_on 'Registrar nova categoria'

      expect(page).to have_content("Ação || criada em: #{Time.zone.now.to_date} por #{admin.email}")
      expect(GameCategory.count).to eq(1)
    end
    it 'unsuccessfully - tried to create a repeated category' do
      admin = create(:admin)
      create(:game_category, name: 'RPG')

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Registrar nova categoria de jogos'
      fill_in 'Nome', with: 'RPG'
      click_on 'Registrar nova categoria'

      expect(page).to have_content('Nome já está em uso')
      expect(GameCategory.count).to eq(1)
    end
    it 'unsuccessfully - tried to create a blank category' do
      admin = create(:admin)

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Registrar nova categoria de jogos'
      click_on 'Registrar nova categoria'

      expect(page).to have_content('Nome não pode ficar em branco')
      expect(GameCategory.count).to eq(0)
    end
  end
  context 'Admin views game categories:' do
    it 'successfully' do
      admin = create(:admin)
      game_category1 = create(:game_category, name: 'RPG')
      game_category2 = create(:game_category, name: 'MOBA')
      game_category3 = create(:game_category, name: 'Ação')

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'

      expect(page).to have_content(
        "#{game_category3.name} || criada em: #{game_category3.creation_date} por #{game_category3.admin.email}"
      )
      expect(page).to have_content(
        "#{game_category2.name} || criada em: #{game_category2.creation_date} por #{game_category2.admin.email}"
      )
      expect(page).to have_content(
        "#{game_category1.name} || criada em: #{game_category1.creation_date} por #{game_category1.admin.email}"
      )
    end
    it 'and there are no game categories registered' do
      admin = create(:admin)

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'

      expect(page).to have_content('Nenhuma categoria de jogo registrada.')
    end
  end
end
