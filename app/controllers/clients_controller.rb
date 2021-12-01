class ClientsController < ApplicationController
  before_action :authenticate_client!, only: %i[my_payment_methods]
  before_action :check_client_token, only: %i[my_payment_methods]
  def my_payment_methods; end
end
