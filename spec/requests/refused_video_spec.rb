require 'rails_helper'

describe 'analysis video' do
  context 'cannot aprrove' do
    it 'without beging  an admin authenticate' do
      video = create(:video)

      post approve_video_path(video)

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(new_admin_session_path)
    end
    it 'if is analysed' do
      video = create(:video, status: 'approved')
      admin = create(:admin)
      login_as admin, scope: :admin

      post approve_video_path(video)

      expect(response).to have_http_status(:permanent_redirect)
      expect(response).to redirect_to(video_path(video))
    end
  end
  context 'cannot refused' do
    it 'without beging  an admin authenticate' do
      video = create(:video)

      post refuse_video_path(video)

      expect(response).to redirect_to(new_admin_session_path)
    end
    it 'if is analysed' do
      video = create(:video, status: 'refused', feed_back: 'não autorizado')
      admin = create(:admin)
      login_as admin, scope: :admin

      post refuse_video_path(video)

      expect(response).to have_http_status(:permanent_redirect)
      expect(response).to redirect_to(video_path(video))
    end
  end
end
