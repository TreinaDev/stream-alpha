class GamesController < ApplicationController
  before_action :authenticate_admin!, only: %i[create new]
  def create
    @game = game_creation
    if @game.save
      redirect_to admin_area_admins_path, notice: 'Jogo cadastrado com sucesso!'
    else
      @categories = GameCategory.all.order(name: :asc)
      render :new
    end
  end

  def new
    @game = Game.new
    @categories = GameCategory.all.order(name: :asc)
  end

  private

  def game_creation
    @game = Game.new(params.require(:game).permit(:name, game_category_ids: []))
    @game.admin = current_admin
    @game.creation_date = Time.zone.now.to_date
    @game
  end
end
