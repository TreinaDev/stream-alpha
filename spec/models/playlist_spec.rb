require 'rails_helper'

RSpec.describe Playlist, type: :model do
  describe 'associations' do
    subject { build(:playlist) }

    it { should belong_to(:admin) }
  end

  describe 'validations' do
    subject { build(:playlist, name: '', description: '') }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_uniqueness_of(:name) }
  end
end
