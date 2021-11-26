require 'rails_helper'

describe 'visitor visit home page' do
  it 'successfully' do
    visit root_path

    click_on 'Entrar'
    expect(current_path).to eq root_path
    expect(page).to have_link('Como administrador')
    expect(page).to have_link('Como streamer')
    expect(page).to have_link('Como assinante')
  end
end
