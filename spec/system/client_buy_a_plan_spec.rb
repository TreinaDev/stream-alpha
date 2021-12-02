require 'rails_helper'

describe 'Client buy a plan' do
  context 'and available plan' do
    it 'Successfully' do
      plano1 = create(:plan)
      plano2 = create(:plan, status: 'qualified')
      plano3 = create(:plan,status: 'qualified')
      plano3 = create(:plan)
      client = create(:client)
      
      login_as client, scope: :client
      visit root_path
      click_on 'Ver todos os Planos'
      
      expect(page).to have_content() 
    end
  end
end