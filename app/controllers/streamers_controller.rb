class StreamersController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create]

  def new
    @streamer = Streamer.new
  end

  def create
    @streamer = Streamer.new(streamer_params)
    if @streamer.save
      redirect_to root_path, notice: t('.success')
    else
      flash[:alert] = t('.failure')
      render :new
    end
  end

  private

  def streamer_params
    params.require(:streamer).permit(:email, :password)
  end
end
