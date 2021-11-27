require 'rails_helper'

RSpec.describe Playlist, type: :model do
  context 'belongs_to' do
    it 'should be streamer' do
      should belong_to(:admin)
    end
  end
  context 'validates' do
    subject { build(:playlist) }
    it 'name must be present' do
      should validate_presence_of(:name).with_message('não pode ficar em branco')
    end
    it 'description must be present' do
      should validate_presence_of(:description).with_message('não pode ficar em branco')
    end
    it 'name must be uniqueness' do
      should validate_uniqueness_of(:name)
    end
  end
  context 'custom validations' do
    it 'cover image cannot be grater than 2 Mb' do
      cover = Playlist.new(cover: Rack::Test::UploadedFile
        .new(Rails.root.join('spec/support/assets/4mb_photo.jpg')))
      cover.valid?

      expect(cover.errors.full_messages_for(:cover)).to include(
        'Capa deve ser menor que 2Mb'
      )
    end
  end
end
