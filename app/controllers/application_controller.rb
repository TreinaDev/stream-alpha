class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    return stored_location_for(resource) || new_client_profile_path if client_profile_blank?
    return stored_location_for(resource) || new_streamer_profile_path if streamer_profile_blank?

    stored_location_for(resource) || root_path
  end

  def authenticate_admin_client_streamer!
    return if current_admin || current_client || current_streamer

    redirect_to root_path,
                alert: t('.unauthorized')
  end

  def authenticate_client_or_admin!
    return if current_client || current_admin

    redirect_to root_path,
                alert: t('.unauthorized')
  end

  def check_client_token
    return unless current_client&.client_profile&.pending?

    current_client.client_profile.register_client_api(current_client)
    redirect_to root_path, notice: t('.get_client_token_error') if current_client.client_profile.pending?
  end

  private

  def client_profile_blank?
    current_client && !current_client.client_profile?
  end

  def streamer_profile_blank?
    current_streamer && current_streamer.streamer_profile.blank?
  end
end
