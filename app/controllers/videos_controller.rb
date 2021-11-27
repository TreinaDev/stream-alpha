class VideosController < ApplicationController
  before_action :authenticate_streamer!, only: %i[new create]
  before_action :authenticate_admin!, only: %i[approve refuse]
  before_action :find_video, only: %i[refuse approve show]
  before_action :analysed_video!, only: %i[refuse approve]
  def new
    @video = Video.new
    @price = Price.new
  end

  def create
    @video = current_streamer.videos.build(video_params)
    if @video.save
      redirect_to @video, notice: t('.success')
      @video.price.value = nil unless @video.price.loose?
    else
      flash[:alert] = "Erro ao criar #{t(:video, scope: 'activerecord.models')}!"
      render :new
    end
  end

  def show
    @video = Video.find(params[:id])
    @price = @video.price
  end

  def payment
    @video = Video.find(params[:id])
    @payment_methods = PaymentMethod.all
  end

  def analysis
    @videos = Video.pending
  end

  def approve
    if @video.price
      @video.register_video_api(@video)
      redirect_to @video, notice: t('.integration_error') and return unless @video.single_video_token
    end
    @video.approved!
    redirect_to @video, notice: t('.success')
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
    params.require(:video).permit(:name, :description, :link, price_attributes: %i[loose value])
  end
end
