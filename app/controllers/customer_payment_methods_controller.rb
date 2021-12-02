class CustomerPaymentMethodsController < ApplicationController
  before_action :authenticate_client!, only: %i[show]
  before_action :check_client_token, only: %i[show]
  before_action :check_pix_and_boleto_tokens, only: %i[show]

  def show
    @client_profile = current_client.client_profile
    @customer_payment_method = @client_profile.customer_payment_method
    @credit_cards = @client_profile.credit_card_settings
  end

  private

  def check_pix_and_boleto_tokens
    @client_profile = current_client.client_profile
    return if @client_profile.client_token_status == 'pending'

    @customer_payment_method = @client_profile.customer_payment_method
    verify_boleto_token(@client_profile, @customer_payment_method)
    verify_pix_token(@client_profile, @customer_payment_method)
    return unless !@customer_payment_method.boleto_token || !@customer_payment_method.pix_token

    redirect_to root_path, notice: t('.get_client_token_error')
  end

  def verify_boleto_token(client_profile, customer_payment_method)
    return unless customer_payment_method.boleto_token.nil?

    customer_payment_method.boleto_token = client_profile.register_client_boleto_and_pix_payment_method(
      'boleto', Rails.configuration.payment_api['company_boleto_token']
    )
  end

  def verify_pix_token(client_profile, customer_payment_method)
    return unless customer_payment_method.pix_token.nil?

    customer_payment_method.pix_token = client_profile.register_client_boleto_and_pix_payment_method(
      'pix', Rails.configuration.payment_api['company_pix_token']
    )
  end
end
