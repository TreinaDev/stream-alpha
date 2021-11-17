require 'rails_helper'

describe 'visitor visit home page' do
  it 'successfully' do
    visit root_path

    expect(current_path).to eq root_path
    expect(page).to have_link('Entrar como Administrador')
    expect(page).to have_link('Entrar como Streamer')
    expect(page).to have_link('Entrar como Assinante')
  end

  it 'visitor register as streamer' do
    visit root_path
    click_on 'Entrar como Streamer'
    click_on 'Cadastrar'
    fill_in 'Email', with: 'jogador@streamer'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme a senha', with: '123456'
    click_on 'Cadastrar'

    expect(current_path).to eq new_streamer_profile_path
    expect(page).to have_content 'Login efetuado com sucesso. Se não foi autorizado, a confirmação será enviada por e-mail.'
  end
end
