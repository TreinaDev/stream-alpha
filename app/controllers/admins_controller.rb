class AdminsController < ApplicationController
  before_action :authenticate_admin!, only: %i[admin_area new create]
  layout 'admin'
  def admin_area
    @games = Game.all
  end

  def admin_contents
    @videos_count = Video.approved.count
    @videos_pendentes = Video.pending.count
    @game_categories = GameCategory.all.order(name: :asc)
    @videos = Video.all.order(created_at: :asc).limit(10)
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
