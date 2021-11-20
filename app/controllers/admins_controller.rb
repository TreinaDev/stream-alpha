class AdminsController < ApplicationController
  before_action :authenticate_admin!, only: %i[admin_area]
  def admin_area
    @game_categories = GameCategory.all
  end
end
