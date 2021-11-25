require 'rails_helper'

RSpec.describe PlaylistVideo, type: :model do
  context 'belongs_to' do
    it 'should be video' do
      should belong_to(:video)
    end
    it 'should be playlist' do
      should belong_to(:playlist)
    end
  end
end
