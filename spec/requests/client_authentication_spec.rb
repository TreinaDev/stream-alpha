require 'rails_helper'

describe 'Client authentication' do
  it 'cannot create a profile without login in as a client' do
    post '/client_profiles'

    expect(response).to redirect_to(new_client_session_path)
  end
  it 'cannot view profile creation page without login in' do
    get '/client_profiles/new'

    expect(response).to redirect_to(new_client_session_path)
  end
  it 'cannot view a profile without login in' do
    create(:client_profile)
    get '/client_profiles/1'

    expect(response).to redirect_to(root_path)
  end
end