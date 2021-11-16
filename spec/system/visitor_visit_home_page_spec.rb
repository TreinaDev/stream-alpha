require 'rails_helper'

describe 'visitor visit home page' do
  it 'successfully' do
    visit root_path

    expect(current_path).to eq root_path
    expect(page).to have_link('Entrar como Administrador')
    expect(page).to have_link('Entrar como Streamer')
    expect(page).to have_link('Entrar como Assinante')
  end
end
