class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    if current_client && (current_client.client_profile.nil? || current_client.client_profile.invalid?)
      stored_location_for(resource) || new_client_profile_path
    else
      stored_location_for(resource) || root_path
    end
  end
end
