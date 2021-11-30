class GamesController < ApplicationController
  before_action :authenticate_admin!, only: %i[create new]
  def create
    @game = game_creation
    if @game.save
      redirect_to games_path, notice: 'Jogo cadastrado com sucesso!'
    else
      @categories = GameCategory.all.order(name: :asc)
      render :new
    end
  end

  def new
    @game = Game.new
    @categories = GameCategory.all.order(name: :asc)
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
