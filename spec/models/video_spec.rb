require 'rails_helper'

RSpec.describe Video, type: :model do
  context 'belongs_to' do
    it 'should be streamer' do
      should belong_to(:streamer)
    end
  end

  context 'feed back presence validations on refused video' do
    subject { build(:video, status: 'refused') }
    it { should validate_presence_of(:feed_back).with_message('não pode ficar em branco') }
  end

  context 'methods' do
    context 'reproved with feedback' do
      it 'is refused with feedback' do
        video = create(:video, status: 'refused', feed_back: 'não atende aos requisitos')

        expect(video.reproved_with_feedback?).to be true
      end
      it 'is refused without feed_back' do
        video = build(:video, status: 'refused')

        expect(video.reproved_with_feedback?).to be false
      end
    end
  end

  context 'API' do
    context 'Registration on PagaPaga' do
      it 'successfully, status == 201' do
        streamer_profile = create(:streamer_profile)
        video = create(:video, name: 'Ocarina of Time Any% WR', status: 'pending', streamer: streamer_profile.streamer)
        create(:price, video: video)
        api_response = File.read(Rails.root.join('spec/support/apis/single_video_registration_201.json'))
        fake_response = double('faraday_response', status: 201, body: api_response)
        allow(SecureRandom).to receive(:alphanumeric).with(20).and_return('154689459647851263as')
        allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/products',
                                              { product: { name: video.name } },
                                              { company_token: '154689459647851263as' })
                                        .and_return(fake_response)

        video.register_video_api(video)

        expect(video.single_video_token).to eq('3fGXrXJ4tAyysV9KW7G2')
      end
      it 'unsuccessfully, status == 500' do
        streamer_profile = create(:streamer_profile)
        video = create(:video, name: 'Ocarina of Time Any% WR', status: 'pending', streamer: streamer_profile.streamer)
        create(:price, video: video)
        fake_response = double('faraday_response', status: 500, body: nil)
        allow(SecureRandom).to receive(:alphanumeric).with(20).and_return('154689459647851263as')
        allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/products',
                                              { product: { name: video.name } },
                                              { company_token: '154689459647851263as' })
                                        .and_return(fake_response)

        video.register_video_api(video)

        expect(video.single_video_token).to eq(nil)
      end
    end
  end
end
