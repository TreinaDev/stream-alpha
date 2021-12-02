require 'rails_helper'

RSpec.describe CustomerPaymentMethod, type: :model do
  context 'API registration - Pix' do
    it 'Successfully == response 201' do
      client_profile = create(:client_profile, client_token_status: 'accepted', token: 'ijlKA9Kxc7Q9vrXOtgTK')
      create(:customer_payment_method, client_profile: client_profile)
      api_response = File.read(Rails.root.join('spec/support/apis/customer_payment_method_pix_creation_201.json'))
      fake_response = double('faraday_response', status: 201, body: api_response)

      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/customer_payment_methods',
                                            {
                                              customer_payment_method: {
                                                customer_token: client_profile.token,
                                                type_of: 'pix',
                                                payment_setting_token: 'VI3wjoM7il0VIOtkl4aj'
                                              }
                                            },
                                            { company_token: Rails.configuration.payment_api['company_auth_token'] })
                                      .and_return(fake_response)

      client_profile.register_client_boleto_and_pix_payment_method('pix', 'VI3wjoM7il0VIOtkl4aj')

      expect(client_profile.customer_payment_method.pix_token).to eq('Zn7Nc8WRp17WPXXfCZbB')
    end
    it 'unsuccessfully == response 422' do
      client_profile = create(:client_profile, client_token_status: 'accepted', token: 'ijlKA9Kxc7Q9vrXOtgTK')
      create(:customer_payment_method, client_profile: client_profile)
      api_response = File.read(Rails.root.join('spec/support/apis/customer_payment_method_pix_creation_error_422.json'))
      fake_response = double('faraday_response', status: 422, body: api_response)

      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/customer_payment_methods',
                                            any_args,
                                            { company_token: Rails.configuration.payment_api['company_auth_token'] })
                                      .and_return(fake_response)

      client_profile.register_client_boleto_and_pix_payment_method('pix', 'VI3wjoM7il0VIOtkl4aj')

      expect(client_profile.customer_payment_method.pix_token).to eq(nil)
    end
    it 'unsuccessfully == response 500' do
      client_profile = create(:client_profile, client_token_status: 'accepted', token: 'ijlKA9Kxc7Q9vrXOtgTK')
      create(:customer_payment_method, client_profile: client_profile)
      fake_response = double('faraday_response', status: 500, body: '')

      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/customer_payment_methods',
                                            {
                                              customer_payment_method: {
                                                customer_token: client_profile.token,
                                                type_of: 'pix',
                                                payment_setting_token: 'VI3wjoM7il0VIOtkl4aj'
                                              }
                                            },
                                            { company_token: Rails.configuration.payment_api['company_auth_token'] })
                                      .and_return(fake_response)

      client_profile.register_client_boleto_and_pix_payment_method('pix', 'VI3wjoM7il0VIOtkl4aj')

      expect(client_profile.customer_payment_method.pix_token).to eq(nil)
    end
  end
  context 'API registration - Boleto' do
    it 'Successfully == response 201' do
      client_profile = create(:client_profile, client_token_status: 'accepted', token: 'ijlKA9Kxc7Q9vrXOtgTK')
      create(:customer_payment_method, client_profile: client_profile)
      api_response = File.read(Rails.root.join('spec/support/apis/customer_payment_method_boleto_creation_201.json'))
      fake_response = double('faraday_response', status: 201, body: api_response)

      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/customer_payment_methods',
                                            {
                                              customer_payment_method: {
                                                customer_token: client_profile.token,
                                                type_of: 'boleto',
                                                payment_setting_token: 'KDE3V0O07j17WGSoFGRC'
                                              }
                                            },
                                            { company_token: Rails.configuration.payment_api['company_auth_token'] })
                                      .and_return(fake_response)

      client_profile.register_client_boleto_and_pix_payment_method('boleto',
                                                                   'KDE3V0O07j17WGSoFGRC')

      expect(client_profile.customer_payment_method.boleto_token).to eq('xn9mc8WiA1nWPXXHCZHB')
    end
    it 'unsuccessfully == response 422' do
      client_profile = create(:client_profile, client_token_status: 'accepted', token: 'ijlKA9Kxc7Q9vrXOtgTK')
      create(:customer_payment_method, client_profile: client_profile)
      api_response = File.read(Rails.root.join('spec/support/apis/' \
                                               'customer_payment_method_boleto_creation_error_422.json'))
      fake_response = double('faraday_response', status: 422, body: api_response)

      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/customer_payment_methods',
                                            any_args,
                                            { company_token: Rails.configuration.payment_api['company_auth_token'] })
                                      .and_return(fake_response)

      client_profile.register_client_boleto_and_pix_payment_method('boleto',
                                                                   'KDE3V0O07j17WGSoFGRC')

      expect(client_profile.customer_payment_method.pix_token).to eq(nil)
    end
    it 'unsuccessfully == response 500' do
      client_profile = create(:client_profile, client_token_status: 'accepted', token: 'ijlKA9Kxc7Q9vrXOtgTK')
      create(:customer_payment_method, client_profile: client_profile)
      fake_response = double('faraday_response', status: 500, body: '')

      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/customer_payment_methods',
                                            {
                                              customer_payment_method: {
                                                customer_token: client_profile.token,
                                                type_of: 'boleto',
                                                payment_setting_token: 'KDE3V0O07j17WGSoFGRC'
                                              }
                                            },
                                            { company_token: Rails.configuration.payment_api['company_auth_token'] })
                                      .and_return(fake_response)

      client_profile.register_client_boleto_and_pix_payment_method('boleto',
                                                                   'KDE3V0O07j17WGSoFGRC')

      expect(client_profile.customer_payment_method.boleto_token).to eq(nil)
    end
  end
end
