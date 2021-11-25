require 'rails_helper'

RSpec.describe Playlist, type: :model do
  context 'belongs_to' do
    it 'should be streamer' do
      should belong_to(:admin)
    end
  end
  context 'validates' do
    it 'name must be present' do
      should validate_presence_of(:name).with_message('não pode ficar em branco')
    end
    it 'discription must be present' do
      should validate_presence_of(:description).with_message('não pode ficar em branco')
    end
  end
end
