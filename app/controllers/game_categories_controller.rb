class GameCategoriesController < ApplicationController
  before_action :authenticate_admin!, only: %i[create new]
  def create
    @game_category = game_category_creation
    if @game_category.save
      redirect_to admin_area_admins_path, notice: 'Categoria criada com sucesso!'
    else
      render :new
    end
  end

  def new
    @game_category = GameCategory.new
  end

  private

  def game_category_creation
    @game_category = GameCategory.new(params.require(:game_category).permit(:name))
    @game_category.admin = current_admin
    @game_category.creation_date = Time.zone.now.to_date
    @game_category
  end
end
