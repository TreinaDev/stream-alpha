class AdminsController < ApplicationController
<<<<<<< HEAD
  def admin_area
  end
end
=======
  before_action :authenticate_admin!, only: %i[admin_area]
  def admin_area
    @game_categories = GameCategory.all
  end
end
>>>>>>> f44d057768d819d8825fe9d7a722ee3dce82fe6c
