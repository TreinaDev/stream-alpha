require 'rails_helper'

describe 'Admin authentication' do
  it 'cannot create a game category without login in as a admin' do
    post '/game_categories'

    expect(response).to redirect_to(new_admin_session_path)
  end
  it 'cannot view game category creation page without login in as a admin' do
    get '/game_categories/new'

    expect(response).to redirect_to(new_admin_session_path)
  end
  it 'cannot access admin area without being logged as a admin' do
    get '/admins/admin_area'

    expect(response).to redirect_to(new_admin_session_path)
  end
end
