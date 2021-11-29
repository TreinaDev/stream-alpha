class VideosController < ApplicationController
  before_action :authenticate_admin!, only: %i[analysis approve refuse]
  before_action :authenticate_admin_client_streamer!, only: %i[show]
  before_action :authenticate_client!, only: %i[payment]
  before_action :authenticate_streamer!, only: %i[new create my_videos]
  before_action :authenticate_streamer_profile!, only: %i[new create my_videos]
  before_action :analysed_video!, only: %i[approve refuse]
  before_action :find_video, only: %i[approve refuse show]
  def new
    @video = current_streamer.videos.new
    @games = Game.all
    @price = Price.new
  end

  def create
    @video = current_streamer.videos.build(video_params)
    @games = Game.all
    if @video.save
      redirect_to @video, notice: t('.success')
      @video.price.value = nil unless @video.price.loose?
    else
      flash[:alert] = t('.fail')
      render :new
    end
  end

  def show
    @video = Video.find(params[:id])
    @price = @video.price
    @streamer_profile = @video.streamer_profile
    @video.update_view_counter
  end

  def index
    @videos = Video.all
  end

  def my_videos
    @videos = current_streamer.streamer_profile.videos
  end

  def analysis
    @videos = Video.pending
  end

  def approve
    @video.approved!
    redirect_to @video, notice: t('.success')
  end

  def refuse
    if @video.update(status: 'refused', feed_back: params[:feed_back])
      redirect_to @video, notice: t('.success')
    else
      @video.status = 'pending'
      @streamer_profile = @video.streamer_profile
      flash[:alert] = t('.fail')
      render :show
    end
  end

  def payment
    @video = Video.find(params[:id])
    @streamer_profile = @video.streamer_profile
    @payment_methods = PaymentMethod.all
  end

  private

  def analysed_video!
    redirect_to @video, status: :permanent_redirect unless find_video.pending?
  end

  def authenticate_streamer_profile!
    redirect_to new_streamer_profile_path if StreamerProfile.find_by(streamer: current_streamer).nil?
  end

  def find_video
    @video = Video.find(params[:id])
  end

  def video_params
    params.require(:video).permit(:name, :description, :link, :game_id, price_attributes: %i[loose value])
  end
end
