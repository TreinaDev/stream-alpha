require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'presence and uniqueness validations' do
    subject { Game.new(admin: create(:admin)) }

    it { should validate_presence_of(:name).with_message('não pode ficar em branco') }
    it { should validate_uniqueness_of(:name).with_message('já está em uso') }
    it { should validate_presence_of(:game_category_ids).with_message('não pode ficar em branco') }
  end
end
