class PlansController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create]
  
  def index
    @plans = Plan.all
  end

  def new
    @video_plan = Plan.new
  end

  def create
    @video_plan = Plan.new(plans_params)
    if @video_plan.save
      redirect_to @video_plan, notice: 'Plano cadastrado com sucesso!'
    else
      render :new
    end
  end

  def show
    @video_plan = Plan.find(params[:id])
    @profiles = []
    @video_plan.streamer.each{ |gamer| @profiles << gamer.streamer_profile }
  end

  private
  
  def plans_params
  params.require(:plan).permit(:name, :description, :value, streamer_ids: [])
  end
end
  