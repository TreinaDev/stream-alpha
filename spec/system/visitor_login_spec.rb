require 'rails_helper'

describe "Visitor login" do
  context "as Streamer" do
    it "successfully" do
      jogador = create(:streamer)

      visit root_path
      click_on 'Entrar como Streamer'
      fill_in 'Email', with: jogador.email
      fill_in 'Senha', with: jogador.password
      click_on 'Entrar'
    
      expect(page).to have_content 'Login efetuado com sucesso!'
    end
  end
end
