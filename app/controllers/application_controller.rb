class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    return stored_location_for(resource) || new_streamer_profile_path if streamer_profile_blank?
    return stored_location_for(resource) || new_client_profile_path if client_profile_blank?

    stored_location_for(resource) || root_path
  end

  def authenticate_client_or_admin!
    return if current_client || current_admin

    redirect_to root_path,
                notice: 'Você não tem permissão para visualizar essa página'
  end

  private

  def streamer_profile_blank?
    current_streamer && current_streamer.streamer_profile.blank?
  end

  def client_profile_blank?
    current_client && !current_client.client_profile?
  end
end
