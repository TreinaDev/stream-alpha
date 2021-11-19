require 'rails_helper'

describe 'Refused video' do
  it 'cannot refuse video without a feed back' do
    create(:video)

    post '/videos/1/refuse_button'

    expect(response).to redirect_to(video_path)
  end
end