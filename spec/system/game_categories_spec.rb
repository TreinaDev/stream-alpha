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
      create(:game_category, name: 'RPG')

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Registrar nova categoria de jogos'
      click_on 'Registrar nova categoria'

      expect(page).to have_content('Nome não pode ficar em branco')
      expect(GameCategory.count).to eq(1)
    end
  end
end
