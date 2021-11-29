require 'rails_helper'

RSpec.describe Plan, type: :model do
  describe 'presence and numericality validations' do
    subject { Plan.new }

    it { should validate_presence_of(:name).with_message('não pode ficar em branco') }
    it { should validate_presence_of(:description).with_message('não pode ficar em branco') }
    it { should validate_numericality_of(:value).with_message('não é um número') }
  end

  context 'API' do
    context 'Registration on PagaPaga' do
      it 'successfully, status == 201' do
        gamer = create(:streamer_profile)
        admin = create(:admin)
        plan = create(:plan)
        api_response = File.read(Rails.root.join('spec/support/apis/plan_registration_201.json'))
        fake_response = double('faraday_response', status: 201, body: api_response)
        allow(SecureRandom).to receive(:alphanumeric).with(20).and_return('bsdjbfjbf41546154523')
        allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/subscriptions',
                                              { subscription: { name: plan.name } },
                                              { company_token: 'bsdjbfjbf41546154523' })
                                        .and_return(fake_response)
        plan.register_plan_api(plan)

        expect(plan.plan_token).to eq('ag54g6sd54gas87d52jk')                                
      end
    end
  end                    
end
