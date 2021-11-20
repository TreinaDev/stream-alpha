require 'rails_helper'

describe 'admin management streamer' do
  it 'can use link with login' do
    admin = create(:admin)
    
    login_as admin, scope: :admin

    visit admin_area_admins_path

    expect(page).to have_link('')
  end
end
