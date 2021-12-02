require 'rails_helper'

RSpec.describe CreditCardSetting, type: :model do
  context 'Registration via API' do
    it 'Successfully: response 201' do
      client = create(:client)
      client_profile = create(:client_profile, client: client, client_token_status: 'accepted',
                                               token: 'ijlKA9Kxc7Q9vrXOtgTK')
      cpm = create(:customer_payment_method, client_profile: client_profile, boleto_token: 'KDE3V0O07j17WGSoFGRC',
                                             pix_token: 'VI3wjoM7il0VIOtkl4aj')
      credit_card = create(:credit_card_setting, customer_payment_method: cpm, token: nil)
      api_response = File.read(Rails.root.join('spec/support/apis/' \
                                               'customer_payment_method_credit_card_creation_201.json'))
      fake_response = double('faraday_response', status: 201, body: api_response)
      api_params = {customer_token: 'ijlKA9Kxc7Q9vrXOtgTK',
                      type_of: 'credit_card',
                      payment_setting_token: 'jRGpRiyoXv96LO538Hjc',
                      credit_card_name: 'Nwando Rolfes',
                      credit_card_number: '4191375734719591',
                      credit_card_expiration_date: '01/2021',
                      credit_card_security_code: '789'
                    }
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/customer_payment_methods',
                                            { customer_payment_method: api_params },
                                            { company_token: Rails.configuration.payment_api['company_auth_token'] })
                                      .and_return(fake_response)
        
      credit_card.credit_card_api_registration(client, api_params)
      expect(credit_card.token).to eq('xn9mc8WiA1nWPXXHCZHB')
    end
    it 'unseccessfully: response 422' do
      client = create(:client)
      client_profile = create(:client_profile, client: client, client_token_status: 'accepted',
                                               token: 'ijlKA9Kxc7Q9vrXOtgTK')
      cpm = create(:customer_payment_method, client_profile: client_profile, boleto_token: 'KDE3V0O07j17WGSoFGRC',
                                             pix_token: 'VI3wjoM7il0VIOtkl4aj')
      credit_card = create(:credit_card_setting, customer_payment_method: cpm, token: nil)
      api_response = File.read(Rails.root.join('spec/support/apis/' \
                                               'customer_payment_method_credit_card_creation_error_422.json'))
      fake_response = double('faraday_response', status: 422, body: api_response)
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/customer_payment_methods',
                                            any_args,
                                            { company_token: Rails.configuration.payment_api['company_auth_token'] })
                                      .and_return(fake_response)
        
      credit_card.credit_card_api_registration(client, nil)
      expect(credit_card.token).to eq(nil)
    end
    it 'unsuccessfully: response 500' do
      client = create(:client)
      client_profile = create(:client_profile, client: client, client_token_status: 'accepted',
                                               token: 'ijlKA9Kxc7Q9vrXOtgTK')
      cpm = create(:customer_payment_method, client_profile: client_profile, boleto_token: 'KDE3V0O07j17WGSoFGRC',
                                             pix_token: 'VI3wjoM7il0VIOtkl4aj')
      credit_card = create(:credit_card_setting, customer_payment_method: cpm, token: nil)
      fake_response = double('faraday_response', status: 500, body: '')
      api_params = {customer_token: 'ijlKA9Kxc7Q9vrXOtgTK',
                      type_of: 'credit_card',
                      payment_setting_token: 'jRGpRiyoXv96LO538Hjc',
                      credit_card_name: 'Nwando Rolfes',
                      credit_card_number: '4191375734719591',
                      credit_card_expiration_date: '01/2021',
                      credit_card_security_code: '789'
                    }
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/customer_payment_methods',
                                            {customer_payment_method: api_params},
                                            { company_token: Rails.configuration.payment_api['company_auth_token'] })
                                      .and_return(fake_response)
        
      credit_card.credit_card_api_registration(client, api_params)
      expect(credit_card.token).to eq(nil)
    end
  end
end
