class StreamerProfilesController < ApplicationController
  before_action :authenticate_admin!, only: %i[active inactive index]
  before_action :authenticate_streamer!, only: %i[new create edit update]
  before_action :find_profile, only: %i[active inactive show edit update]
  before_action :profile_exists!, only: %i[new create]
  before_action :streamer_is_owner!, only: %i[edit update]

  def new
    @streamer_profile = StreamerProfile.new
  end

  def create
    @streamer_profile = current_streamer.build_streamer_profile(streamer_profile_params)

    if @streamer_profile.save
      @streamer_profile.streamer.completed!
      redirect_to @streamer_profile, notice: t('.success')
    else
      flash[:alert] = t('.failure')
      render :new
    end
  end

  def show; end

  def index
    @streamers = StreamerProfile.all
  end

  def edit
    @streamer_profile = StreamerProfile.find(params[:id])
  end

  def update
    @streamer_profile = StreamerProfile.find(params[:id])

    if @streamer_profile.update(streamer_profile_params)
      redirect_to @streamer_profile, notice: t('.success')
    else
      flash[:alert] = t('.failure')
      render :edit
    end
  end

  def active
    redirect_to @streamer_profile, notice: t('.success') if @streamer_profile.active!
  end

  def inactive
    redirect_to @streamer_profile, notice: t('.success') if @streamer_profile.inactive!
  end

  private

  def find_profile
    @streamer_profile = StreamerProfile.find(params[:id])
  end

  def profile_exists!
    return if StreamerProfile.find_by(streamer: current_streamer).nil?

    redirect_to current_streamer.streamer_profile, alert: t('.profile_exists')
  end

  def streamer_is_owner!
    @streamer_profile = StreamerProfile.find(params[:id])
    return if @streamer_profile.owner?(current_streamer)

    redirect_to root_path, alert: t('.unauthorized_profile')
  end

  def streamer_profile_params
    params.require(:streamer_profile).permit(:name, :description, :facebook,
                                             :instagram, :twitter,
                                             :streamer_id, :photo)
  end
end
