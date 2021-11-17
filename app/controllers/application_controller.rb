class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    if current_client&.client_profile?
      stored_location_for(resource) || root_path
    else
      stored_location_for(resource) || new_client_profile_path
    end
  end

  def authenticate_client_or_admin!
    return if current_client || current_admin

    redirect_to root_path,
                notice: 'Você não tem permissão para visualizar essa página'
  end
end
