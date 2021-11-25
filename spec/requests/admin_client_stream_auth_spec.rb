require 'rails_helper'

describe 'Admin, Client, Streamer authentication' do
  it 'cannot view video without login' do
    video = create(:video)
    get "/videos/#{video.id}"

    expect(response).to redirect_to(root_path)
  end
end
