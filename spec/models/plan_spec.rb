require 'rails_helper'

RSpec.describe Plan, type: :model do
  describe 'presence and numericality validations' do
    subject { Plan.new }

    it { should validate_presence_of(:name).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:description).with_message('não pode ficar em branco') }
    it { should validate_numericality_of(:value).with_message('não é um número') }
  end
end
