class VideosController < ApplicationController
  before_action :authenticate_streamer!, only: %i[new create]
  def new
    @video = Video.new
  end

  def create
    @video = current_streamer.videos.build(video_params)
    if @video.save
      redirect_to @video, notice: 'Video cadastrado com sucesso!'
    else
      render :new
    end
  end

  def show
    @video = Video.find(params[:id])
  end

  private

  def video_params
    params.require(:video).permit(:name, :description, :name_game, :link, :duration, :loose)
  end
end
