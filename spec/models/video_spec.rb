require 'rails_helper'

RSpec.describe Video, type: :model do
  context 'belongs_to' do
    it 'should be streamer' do
      should belong_to(:streamer)
    end
  end

  context 'presence validations' do
    subject { Video.new }

    it { should validate_presence_of(:name).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:description).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:link).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:game_category).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:subcategory).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:game_name).with_message('não pode ficar em branco') }
  end
end
