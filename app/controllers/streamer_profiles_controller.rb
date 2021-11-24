class StreamerProfilesController < ApplicationController
  before_action :authenticate_streamer!, only: %i[new create edit update]
  before_action :streamer_is_owner!, only: %i[edit update]

  def show
    @streamer_profile = StreamerProfile.find(params[:id])
  end

  def new
    @streamer_profile = StreamerProfile.new

    redirect_to current_streamer.streamer_profile, alert: 'Perfil já existente!' if streamer_profile_exists?
  end

  def create
    @streamer_profile = current_streamer.build_streamer_profile(streamer_profile_params)

    if streamer_profile_exists?
      redirect_to current_streamer.streamer_profile, alert: 'Perfil já existente!'
    elsif @streamer_profile.save
      redirect_to @streamer_profile, notice: "#{t(:streamer_profile, scope: 'activerecord.models')} criado com sucesso!"
    else
      flash[:alert] = "Erro ao criar #{t(:streamer_profile, scope: 'activerecord.models')}!"
      render :new
    end
  end

  def edit
    @streamer_profile = StreamerProfile.find(params[:id])
  end

  def update
    @streamer_profile = StreamerProfile.find(params[:id])

    if @streamer_profile.update(streamer_profile_params)
      redirect_to @streamer_profile, notice: 'Perfil atualizado com sucesso!'
    else
      flash[:alert] = "Erro ao atualizar #{t(:streamer_profile, scope: 'activerecord.models')}!"
      render :edit
    end
  end

  private

  def streamer_is_owner!
    @streamer_profile = StreamerProfile.find(params[:id])
    return if @streamer_profile.owner?(current_streamer)

    redirect_to root_path, alert: "Você só pode editar o seu #{t(:streamer_profile, scope: 'activerecord.models')}!"
  end

  def streamer_profile_exists?
    !StreamerProfile.find_by(streamer: current_streamer).nil?
  end

  def streamer_profile_params
    params.require(:streamer_profile).permit(:name, :description, :facebook,
                                             :instagram, :twitter,
                                             :streamer_id, :photo)
  end
end
