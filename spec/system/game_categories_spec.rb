require 'rails_helper'

describe 'game categories' do
  context 'Admin register game categories:' do
    it 'successfully' do
      admin = create(:admin)

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Cadastrar Categoria de Jogos'
      fill_in 'Nome', with: 'Ação'
      click_on 'Categoria de Jogos'

      expect(page).to have_content('Ação')
      expect(page).to have_content(I18n.l(Time.zone.now.to_date))
      expect(page).to have_content(admin.email)
      expect(GameCategory.count).to eq(1)
    end
    it 'unsuccessfully - tried to create a repeated category' do
      admin = create(:admin)
      create(:game_category, name: 'RPG')

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Cadastrar Categoria de Jogos'
      fill_in 'Nome', with: 'RPG'
      click_on 'Criar Categoria de Jogos'

      expect(page).to have_content('Nome já está em uso')
      expect(GameCategory.count).to eq(1)
    end
    it 'unsuccessfully - tried to create a blank category' do
      admin = create(:admin)

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'
      click_on 'Cadastrar Categoria de Jogos'
      click_on 'Categoria de Jogos'

      expect(page).to have_content('Nome não pode ficar em branco')
      expect(GameCategory.count).to eq(0)
    end
  end
  context 'Admin views game categories:' do
    it 'successfully' do
      admin = create(:admin)
      game_category1 = create(:game_category, name: 'RPG', created_at: 3.months.ago)
      game_category2 = create(:game_category, name: 'MOBA', created_at: 2.months.ago)
      game_category3 = create(:game_category, name: 'Ação', created_at: 1.month.ago)

      login_as admin, scope: :admin
      visit root_path
      click_on 'Área do administrador'

      expect(page).to have_content(game_category1.name)
      expect(page).to have_content(I18n.l(game_category1.created_at.to_date))
      expect(page).to have_content(game_category1.admin.email)
      expect(page).to have_content(game_category2.name)
      expect(page).to have_content(I18n.l(game_category2.created_at.to_date))
      expect(page).to have_content(game_category2.admin.email)
      expect(page).to have_content(game_category3.name)
      expect(page).to have_content(I18n.l(game_category3.created_at.to_date))
      expect(page).to have_content(game_category3.admin.email)
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
