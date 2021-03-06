class GameCategoriesController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create]

  def new
    @game_category = GameCategory.new
  end

  def create
    @game_category = current_admin.game_categories.new(game_category_params)

    if @game_category.save
      redirect_to game_categories_path,
                  notice: t('.success')
    else
      flash[:alert] = t('.failure')
      render :new
    end
  end

  def index
    @game_categories = GameCategory.all.order(name: :asc)
  end

  private

  def game_category_params
    params.require(:game_category).permit(:name)
  end
end
