require 'rails_helper'

RSpec.describe Video, type: :model do
  context 'belongs_to' do
    it 'should be streamer' do
      should belong_to(:streamer)
    end
  end

  context 'feed back presence validations on refused video' do
    subject { create(:video).refused! }

    it { should validate_presence_of(:feed_back).with_message('não pode ficar em branco') }
  end
end
