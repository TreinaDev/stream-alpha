class PlansController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create]

  def index
    @plans = Plan.all
  end

  def new
    @video_plan = Plan.new
    @streamers = Streamer.completed
  end

  def create
    @video_plan = Plan.new(plans_params)
    @streamers = Streamer.completed
    if @video_plan.save
      redirect_to @video_plan, notice: 'Plano cadastrado com sucesso!'
    else
      render :new
    end
  end

  def show
    @video_plan = Plan.find(params[:id])
  end

  private

  def plans_params
    params.require(:plan).permit(:name, :description, :value, streamer_ids: [])
  end
end
