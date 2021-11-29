require 'rails_helper'

describe 'streamer autheticated' do
  context 'cannot' do
    it 'register video without login' do
      get new_video_path

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(new_streamer_session_path)
    end

    it 'create video without login' do
      post videos_path

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(new_streamer_session_path)
    end

    it 'Tries to create a video without a profile - #new' do
      streamer = create(:streamer)

      login_as streamer, scope: :streamer
      get new_video_path

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(new_streamer_profile_path)
    end

    it 'Tries to create a video without a profile - #create' do
      streamer = create(:streamer)

      login_as streamer, scope: :streamer
      post videos_path

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(new_streamer_profile_path)
    end

    it 'cannot create a second profile - #new' do
      streamer = create(:streamer)
      create(:streamer_profile, streamer: streamer)

      login_as streamer, scope: :streamer
      get '/streamer_profiles/new'

      expect(response).to redirect_to(streamer.streamer_profile)
    end
  end
end
