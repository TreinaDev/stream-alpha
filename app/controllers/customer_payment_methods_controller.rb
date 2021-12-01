class CustomerPaymentMethodsController < ApplicationController
  before_action :authenticate_client!, only: %i[show]
  before_action :check_client_token, only: %i[show]
  before_action :check_pix_and_boleto_tokens, only: %i[show]

  def show
    @customer_payment_method = current_client.client_profile.customer_payment_method
  end

  private

  def check_pix_and_boleto_tokens
    return if current_client.client_profile.client_token_status == "pending"
    if current_client.client_profile.customer_payment_method.pix_token.nil?
      current_client.client_profile.register_client_pix_payment_method(current_client)
    end
    if current_client.client_profile.customer_payment_method.boleto_token.nil?
      current_client.client_profile.register_client_boleto_payment_method(current_client)
    end
    if current_client.client_profile.customer_payment_method.pix_token.nil? || current_client.client_profile.customer_payment_method.boleto_token.nil?
      redirect_to root_path,
                  notice: t('.get_client_token_error')
    end
  end
end
