class GameCategoriesController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create]
  def new
    @game_category = GameCategory.new
  end

  def create
    @game_category = current_admin.game_categories.new(game_category_params)
    if @game_category.save
      redirect_to admin_area_admins_path,
                  notice: "#{t(:game_category, scope: 'activerecord.models')} criada com sucesso!"
    else
      flash[:alert] = "Erro ao criar #{t(:game_category, scope: 'activerecord.models')}!"
      render :new
    end
  end

  private

  def game_category_params
    params.require(:game_category).permit(:name)
  end
end
