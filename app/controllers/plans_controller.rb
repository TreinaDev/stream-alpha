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
    if @video_plan.valid?
      @video_plan.register_plan_api(@video_plan)
    end
    if @video_plan.save
      redirect_to @video_plan, notice: t('.plan_pending') if @video_plan.down?
      redirect_to @video_plan, notice: t('.success') if @video_plan.qualified?
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
