class PlansController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create]

  def new
    @video_plan = Plan.new
    @streamers = Streamer.completed
    @playlists = Playlist.all
  end

  def create
    @video_plan = Plan.new(plans_params)
    load_dependencies

    if @video_plan.save
      @video_plan.register_plan_api(@video_plan)
      redirect_to @video_plan, notice: t('.plan_pending') if @video_plan&.down?
      redirect_to @video_plan, notice: t('.success') if @video_plan&.qualified?
    else
      flash[:alert] = t('.failure')
      render :new
    end
  end

  def show
    @video_plan = Plan.find(params[:id])
  end

  def index
    @plans = Plan.all
  end

  private

  def load_dependencies
    @streamers = Streamer.completed
    @playlists = Playlist.all
  end

  def plans_params
    params.require(:plan).permit(:name, :description, :value, streamer_ids: [], playlist_ids: [])
  end
end
