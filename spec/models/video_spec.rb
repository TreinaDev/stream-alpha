require 'rails_helper'

RSpec.describe Video, type: :model do
  context 'belongs_to' do
    it 'should be streamer' do
      should belong_to(:streamer)
    end
    it 'should be game category' do
      should belong_to(:game_category)
    end
  end
  context 'validations' do
    context 'presence' do
      it 'name must be present' do
        should validate_presence_of(:name).with_message('não pode ficar em branco')
      end
      it 'description must be present' do
        should validate_presence_of(:description).with_message('não pode ficar em branco')
      end
      it 'link must be present' do
        should validate_presence_of(:link).with_message('não pode ficar em branco')
      end
    end
  end
end
