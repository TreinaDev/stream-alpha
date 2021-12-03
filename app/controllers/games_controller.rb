class GamesController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create]

  def new
    @game = Game.new
    @categories = GameCategory.all.order(name: :asc)
  end

  def create
    @game = game_creation

    if @game.save
      redirect_to games_path, notice: t('.success')
    else
      @categories = GameCategory.all.order(name: :asc)
      flash[:alert] = t('.failure')
      render :new
    end
  end

  def index
    @games = Game.all.order(name: :asc)
  end

  private

  def game_creation
    @game = Game.new(params.require(:game).permit(:name, game_category_ids: []))
    @game.admin = current_admin
    @game
  end
end
