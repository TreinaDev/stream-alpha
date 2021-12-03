require 'rails_helper'

describe 'Client buy' do
  context 'an available plan' do
    it 'but first click on the link to see the plans' do
      plan1 = create(:plan)
      plan2 = create(:plan, plan_status: 'qualified')
      plan3 = create(:plan,plan_status: 'qualified')
      plan3 = create(:plan)
      client = create(:client)
      
      login_as client, scope: :client
      visit root_path
      click_on 'Ver todos os Planos'
      
      expect(page).to have_content(plan2.name)
      expect(page).to have_content(plan2.name)
      expect(current_path).to eq(plans_path) 
    end
  end
end