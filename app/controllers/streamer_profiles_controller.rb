class StreamerProfilesController < ApplicationController
  before_action :authenticate_streamer!, only: %i[new create]

  def show
    @streamer_profile = StreamerProfile.find(params[:id])
  end

  def new
    @streamer_profile = StreamerProfile.new

    redirect_to current_streamer.streamer_profile, alert: 'Perfil já existente!' if streamer_profile_exists?
  end

  def create
    @streamer_profile = StreamerProfile.new(streamer_profile_params)
    @streamer_profile.streamer = current_streamer

    if streamer_profile_exists?
      redirect_to current_streamer.streamer_profile, alert: 'Perfil já existente!'
    elsif @streamer_profile.save
      redirect_to @streamer_profile, notice: "#{t(:streamer_profile, scope: 'activerecord.models')} criado com sucesso!"
    else
      render :new, alert: "Erro ao criar um #{t(:streamer_profile, scope: 'activerecord.models')}!"
    end
  end

  private

  def streamer_profile_exists?
    !StreamerProfile.find_by(streamer: current_streamer).nil?
  end

  def streamer_profile_params
    params.require(:streamer_profile).permit(:name, :description, :facebook,
                                             :instagram, :twitter,
                                             :streamer_id)
  end
end
