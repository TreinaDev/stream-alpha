class CreditCardSettingsController < ApplicationController
  before_action :authenticate_client!, only: %i[new]
  def new
    @client_profile = current_client.client_profile
    @customer_payment_method = @client_profile.customer_payment_method
    @credit_card_setting = CreditCardSetting.new
  end

  def create
    @credit_card = CreditCardSetting.new
    @credit_card.credit_card_api_registration(api_params(params))
  end

  private

  def api_params(params)
    {
      customer_token: current_client.client_profile.token,
      type_of: 'credit_card',
      payment_setting_token: Rails.configuration.payment_api['company_credit_card_token'],
      credit_card_name: params[:credit_card_name],
      credit_card_number: params[:credit_card_number],
      credit_card_expiration_date: params[:credit_card_expiration_date],
      credit_card_security_code: params[:credit_card_security_code]
    }
  end

  def credit_card_creation
    @credit_card = CreditCardSetting.new(params.require(:credit_card_setting).permit(:nickname))
  end
end
