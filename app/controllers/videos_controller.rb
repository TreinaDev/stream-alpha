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

  def analysis
    @videos = Video.videos_pending
  end

  def approve_button
    @video = Video.find(params[:id])
    approve_video(@video)
    if @video.approved?
      redirect_to @video, notice: 'Video aprovado com sucesso!'
    end
  end

  def refuse_button
    @video = Video.find(params[:id])
    @video.feed_back = params[:feed_back]
    refuse_video(@video)
    if @video.feed_back.nil?
      render :show
    else
      @video.save
      redirect_to @video
    end
  end

  private

  def video_params
    params.require(:video).permit(:name, :description, :link)
  end

  def approve_video(video)
    video.approved!
  end

  def refuse_video(video)
    video.refused!
  end
end
