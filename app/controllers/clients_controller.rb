class ClientsController < ApplicationController
  before_action :authenticate_client!, only: %i[my_payment_methods]
  before_action :check_client_token, only: %i[my_payment_methods]
  def my_payment_methods
    response = Faraday.get("http://localhost:4000/api/v1/customer/#{current_client.client_profile.token}",
                           { company_token: Rails.configuration.payment_api['company_auth_token'] })
    if response.status == 200
    end
  end
end
