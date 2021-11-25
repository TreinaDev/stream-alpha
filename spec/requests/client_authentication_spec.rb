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
  it 'cannot create a second profile - action new' do
    client = create(:client)
    create(:client_profile, client: client)

    login_as client, scope: :client
    get '/client_profiles/new'

    expect(response).to redirect_to(client.client_profile)
  end
  it 'cannot edit another user profile - action edit' do
    client = create(:client)
    client2 = create(:client)
    create(:client_profile, client: client)
    create(:client_profile, client: client2)

    login_as client, scope: :client
    get '/client_profiles/2/edit'

    expect(response).to redirect_to(root_path)
  end
  it 'cannot edit another user profile - action update' do
    client = create(:client)
    client2 = create(:client)
    create(:client_profile, client: client)
    create(:client_profile, client: client2)

    login_as client, scope: :client
    patch '/client_profiles/2'

    expect(response).to redirect_to(root_path)
  end
end
