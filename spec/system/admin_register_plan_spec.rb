require 'rails_helper'

describe 'Admin' do
  context "register a streamer's video plan" do
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

    it 'but fills wrong' do
      admin = create(:admin) 
      gamer = create(:streamer)
      profile = create(:streamer_profile, streamer: gamer)

      visit root_path
      click_on 'Entrar como Administrador'
      fill_in 'Email', with: admin.email
      fill_in 'Password', with: admin.password
      click_on 'Log in'
      click_on 'Área do administrador'
      click_on 'Cadastrar Plano'
      fill_in 'Nome do Plano', with: ''
      fill_in 'Descrição', with: ''
      fill_in 'Valor', with: ''
      select "#{gamer.email}", from: 'Selecione os Streamer incluídos no plano'
      click_on 'Criar Plano de Assinatura'

      expect(page).to have_content('Nome do Plano não pode ficar em branco')
      expect(page).to have_content('Descrição não pode ficar em branco')
      expect(page).to have_content('Valor não pode ficar em branco')
      expect(page).to have_content('Valor não é um número')
    end

    it 'successfully' do
      admin = create(:admin) 
      gamer = create(:streamer)
      profile = create(:streamer_profile, streamer: gamer)

      visit root_path
      click_on 'Entrar como Administrador'
      fill_in 'Email', with: admin.email
      fill_in 'Password', with: admin.password
      click_on 'Log in'
      click_on 'Área do administrador'
      click_on 'Cadastrar Plano'
      fill_in 'Nome do Plano', with: 'Plano Gamer'
      fill_in 'Descrição', with: 'Desbloqueia todos videos de um Streamer'
      fill_in 'Valor', with: '100'
      select "#{gamer.email}", from: 'Selecione os Streamer incluídos no plano'
      click_on 'Criar Plano de Assinatura'

      expect(page).to have_content('Plano cadastrado com sucesso!')
    end
  end
  context 'view all plans registred' do 
    it 'successfuly' do
      admin = create(:admin) 
      plano_a = create(:plan)
      plano_b = create(:plan)
      plano_c = create(:plan)

      visit root_path
      click_on 'Entrar como Administrador'
      fill_in 'Email', with: admin.email
      fill_in 'Password', with: admin.password
      click_on 'Log in'
      click_on 'Área do administrador'
      click_on 'Planos de Assinatura'
      
      expect(page).to have_content("#{plano_a.name}")
      expect(page).to have_content("#{plano_b.name}")
      expect(page).to have_content("#{plano_c.name}")  
    end
  end
end