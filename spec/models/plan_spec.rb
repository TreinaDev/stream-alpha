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
        create(:streamer_profile)
        create(:admin)
        plan = create(:plan)
        api_response = File.read(Rails.root.join('spec/support/apis/plan_registration_201.json'))
        fake_response = double('faraday_response', status: 201, body: api_response)
        allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/products',
                                              { product: { name: plan.name, type_of: 'subscription',
                                                           status: 'enabled' } },
                                              { company_token: Rails.configuration.payment_api['company_auth_token'] })
                                        .and_return(fake_response)
        plan.register_plan_api(plan)

        expect(plan.plan_token).to eq('ag54g6sd54gas87d52jk')
      end

      it 'and PagaPaga server unable, status == 500' do
        create(:streamer_profile)
        create(:admin)
        plan = create(:plan)
        fake_response = double('faraday_response', status: 500, body: nil)
        allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/products',
                                              { product: { name: plan.name, type_of: 'subscription',
                                                           status: 'enabled' } },
                                              { company_token: Rails.configuration.payment_api['company_auth_token'] })
                                        .and_return(fake_response)
        plan.register_plan_api(plan)

        expect(plan.plan_token).to eq(nil)
      end

      it 'and there is a validation error, status == 422' do
        create(:streamer_profile)
        create(:admin)
        plan = create(:plan)
        api_response = File.read(Rails.root.join('spec/support/apis/plan_registration_422.json'))
        fake_response = double('faraday_response', status: 422, body: api_response)
        allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/products',
                                              { product: { name: plan.name, type_of: 'subscription',
                                                           status: 'enabled' } },
                                              { company_token: Rails.configuration.payment_api['company_auth_token'] })
                                        .and_return(fake_response)

        plan.register_plan_api(plan)

        expect(plan.plan_token).to eq(nil)
        expect(api_response['message']).presence
      end
    end
  end
end
