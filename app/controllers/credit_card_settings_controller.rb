class CreditCardSettingsController < ApplicationController
  before_action :authenticate_client!, only: %i[new]
  def new
    @client_profile = current_client.client_profile
    @customer_payment_method = @client_profile.customer_payment_method
    @credit_card_setting = CreditCardSetting.new
  end

  def create
    @credit_card = CreditCardSetting.new(params.require(:credit_card_setting).permit(:nickname))
    @credit_card.customer_payment_method = current_client.client_profile.customer_payment_method
    @credit_card.encrypt_credit_card_digits(params[:credit_card_setting][:credit_card_number])
    @credit_card.credit_card_api_registration(current_client, api_params)
    if @credit_card.token.nil?
      redirect_to new_client_profile_customer_payment_method_credit_card_setting_path(current_client.client_profile, current_client.client_profile.customer_payment_method)
    else
      @credit_card.save
      redirect_to client_profile_customer_payment_method_path(current_client.client_profile, @credit_card.customer_payment_method)
    end
  end

  private

  def api_params
    {
      customer_token: current_client.client_profile.token,
      type_of: 'credit_card',
      payment_setting_token: Rails.configuration.payment_api['company_credit_card_token'],
      credit_card_name: params[:credit_card_setting][:credit_card_name],
      credit_card_number: params[:credit_card_setting][:credit_card_number],
      credit_card_expiration_date: params[:credit_card_setting][:credit_card_expiration_date],
      credit_card_security_code: params[:credit_card_setting][:credit_card_security_code]
    }
  end
end
