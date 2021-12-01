class AdminsController < ApplicationController
  before_action :authenticate_admin!, only: %i[admin_area new create]
  layout 'admin'
  def admin_area
    @games = Game.all
    @clients_count = Client.all.count
    @streamers_count = Streamer.all.count
    @total_views = Video.all.sum(:visualization)
  end

  def admin_contents
    @videos = Video.all.order(created_at: :asc).limit(4)
    @game_categories = GameCategory.all.order(name: :asc)
    @videos_count = Video.approved.count
    @videos_pending_count = Video.pending.count
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
