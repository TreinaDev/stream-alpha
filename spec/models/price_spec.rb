require 'rails_helper'

RSpec.describe Price, type: :model do
  describe 'Validations:' do
    context 'price should be number' do
      subject { build(:price, loose: true, value: 'fasdjbfbc') }
      it { should validate_numericality_of(:value).with_message('não é um número') }
    end
  end
end
