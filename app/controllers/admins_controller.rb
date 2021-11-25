class AdminsController < ApplicationController
  before_action :authenticate_admin!, only: %i[admin_area new create]
  def admin_area
    @game_categories = GameCategory.all
    @games = Game.all
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      redirect_to root_path, notice: 'Administrador cadastrado com sucesso!'
    else
      render :new
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:email, :password)
  end
end
