require 'rails_helper'

RSpec.describe GameCategory, type: :model do
  describe 'presence and uniqueness validations' do
    subject { GameCategory.new }

    it { should validate_presence_of(:name).with_message('não pode ficar em branco') }
    it { should validate_uniqueness_of(:name).with_message('já está em uso') }
  end
end
