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
      subject = build(:video, duration: 'asfnfjcf')
      
      subject.valid?

      expect(subject.errors.full_messages_for(:duration)).to include(
        'Duração deve inserir minutos e segundos. Exemplo 139:59 (139 minutos 59 segundos)'
      )
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
end
