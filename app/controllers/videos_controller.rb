class VideosController < ApplicationController
  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save!
      redirect_to video_path(@video.id)
      flash[:notice] = 'Video cadastrado com sucesso!'
    end
  end

  def show
    @video = Video.find(params[:id])
  end

  private

  def video_params
    params.require(:video).permit(:name, :description, :link)
  end
end