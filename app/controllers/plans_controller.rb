class PlansController < ApplicationController
    before_action :authenticate_admin!, only: %i[new create]
    
    def new
        @video_plan = Plan.new
    end

end
  