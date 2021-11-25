require 'rails_helper'

RSpec.describe PlaylistStreamer, type: :model do
  context 'belongs_to' do
    it 'should be streamer' do
      should belong_to(:streamer)
    end
    it 'should be playlist' do
      should belong_to(:playlist)
    end
  end
end
