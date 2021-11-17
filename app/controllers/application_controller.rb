class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    if current_streamer && current_streamer.streamer_profile.nil?
      stored_location_for(resource) || new_streamer_profile_path
    else
      stored_location_for(resource) || root_path
    end
  end
end
