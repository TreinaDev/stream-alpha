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
  end
end
