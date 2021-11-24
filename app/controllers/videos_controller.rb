class VideosController < ApplicationController
  before_action :authenticate_streamer!, only: %i[new create]
  before_action :authenticate_admin!, only: %i[approve refuse]
  before_action :find_video, only: %i[refuse approve show]
  before_action :analysed_video!, only: %i[refuse approve]
  def new
    @video = Video.new
  end

  def create
    @video = current_streamer.videos.build(video_params)
    if @video.save
      redirect_to @video, notice: t('.success')
    else
      flash[:alert] = "Erro ao criar #{t(:video, scope: 'activerecord.models')}!"
      render :new
    end
  end

  def show
    @video = Video.find(params[:id])
  end

  def payment
    @video = Video.find(params[:id])
    @payment_methods = PaymentMethod.all
  end

  def analysis
    @videos = Video.pending
  end

  def approve
    redirect_to @video, notice: t('.success') if @video.approved!
  end

  def index
    @videos = Video.all
  end

  def refuse
    if @video.update(status: 'refused', feed_back: params[:feed_back])
      redirect_to @video, notice: t('.success')
    else
      @video.status = 'refused'
      render :show
    end
  end

  private

  def find_video
    @video = Video.find(params[:id])
  end

  def analysed_video!
    redirect_to @video, status: :permanent_redirect unless find_video.pending?
  end

  def video_params
    params.require(:video).permit(:name, :description, :link)
  end

  def approve_video(video)
    video.approved!
  end
end
