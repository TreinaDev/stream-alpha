class CustomerPaymentMethodsController < ApplicationController
  before_action :authenticate_client!, only: %i[show]
  before_action :check_client_token, only: %i[show]
  before_action :check_pix_and_boleto_tokens, only: %i[show]

  def show
    @customer_payment_method = current_client.client_profile.customer_payment_method
  end

  private

  def check_pix_and_boleto_tokens
    @client_profile = current_client.client_profile
    return if current_client.client_profile.client_token_status == 'pending'

    if @client_profile.customer_payment_method.boleto_token.nil?
      @client_profile.customer_payment_method.boleto_token = @client_profile.register_client_boleto_and_pix_payment_method(
        current_client, 'boleto', Rails.configuration.payment_api['company_boleto_token']
      )
    end
    if @client_profile.customer_payment_method.pix_token.nil?
      @client_profile.customer_payment_method.pix_token = @client_profile.register_client_boleto_and_pix_payment_method(
        current_client, 'pix', Rails.configuration.payment_api['company_pix_token']
      )
    end
    if @client_profile.customer_payment_method.boleto_token.nil? || @client_profile.customer_payment_method.pix_token.nil?
      redirect_to root_path,
                  notice: t('.get_client_token_error')
    end
  end
end
