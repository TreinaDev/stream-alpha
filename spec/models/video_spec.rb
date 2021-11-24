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
    it { should validate_presence_of(:name_game).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:duration).with_message('não pode ficar em branco') }
  end

  context 'custom validations' do
    it 'duration most be number' do
      subject { bluild(:video, duration: 'asfnfjcf') }
      
      subject.valid?

      expect(subject.errors.full_messages_for(:duration)).to include(
        'Deve inserir minutos e segundos. Exemplo 139:59 (139 minutos 59 segundos)'
      )
    end
    
    it ' ans cannot be greater the 140 minutes' do
    end
  end
end
