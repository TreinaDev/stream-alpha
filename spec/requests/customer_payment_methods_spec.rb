require 'rails_helper'

describe 'Customer Payment Methods viewing' do
  it 'Client tries to view his payment methods that were not constructed - Pix' do
    client = create(:client)
    client_profile = create(:client_profile, client: client, client_token_status: 'accepted',
                                             token: 'ijlKA9Kxc7Q9vrXOtgTK')
    cpm = create(:customer_payment_method, client_profile: client_profile, boleto_token: 'KDE3V0O07j17WGSoFGRC',
                                           pix_token: nil)
    fake_response = double('faraday_response', status: 500, body: '')

    allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/customer_payment_methods',
                                          {
                                            customer_payment_method: {
                                              customer_token: client_profile.token,
                                              type_of: 'pix',
                                              payment_setting_token: 'VI3wjoM7il0VIOtkl4aj'
                                            }
                                          },
                                          { companyToken: Rails.configuration.payment_api['company_auth_token'] })
                                    .and_return(fake_response)
    login_as client, scope: :client
    get client_profile_customer_payment_method_path(client_profile, cpm)

    expect(response).to redirect_to(root_path)
  end
  it 'Client tries to view his payment methods that were not constructed - Bill' do
    client = create(:client)
    client_profile = create(:client_profile, client: client, client_token_status: 'accepted',
                                             token: 'ijlKA9Kxc7Q9vrXOtgTK')
    cpm = create(:customer_payment_method, client_profile: client_profile, boleto_token: nil,
                                           pix_token: 'VI3wjoM7il0VIOtkl4aj')
    fake_response = double('faraday_response', status: 500, body: '')

    allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/customer_payment_methods',
                                          {
                                            customer_payment_method: {
                                              customer_token: client_profile.token,
                                              type_of: 'boleto',
                                              payment_setting_token: 'KDE3V0O07j17WGSoFGRC'
                                            }
                                          },
                                          { companyToken: Rails.configuration.payment_api['company_auth_token'] })
                                    .and_return(fake_response)
    login_as client, scope: :client
    get client_profile_customer_payment_method_path(client_profile, cpm)

    expect(response).to redirect_to(root_path)
  end
end
