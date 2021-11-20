class GameCategoriesController < ApplicationController
  before_action :authenticate_admin!, only: %i[create new]
  def create
    @game_category = current_admin.game_categories.new(game_category_params)
    if @game_category.save
      redirect_to admin_area_admins_path,
                  notice: "#{t(:game_category, scope: 'activerecord.models')} criada com sucesso!"
    else
      render :new, alert: "Erro ao criar #{t(:game_category, scope: 'activerecord.models')}!"
    end
  end

  def new
    @game_category = GameCategory.new
  end

  private

  def game_category_params
    params.require(:game_category).permit(:name)
  end
end
