class StreamerProfilesController < ApplicationController
  before_action :authenticate_streamer!, only: %i[new create edit update]
  before_action :authenticate_admin!, only: %i[index active inactive]
  before_action :find_profile, only: %i[show edit update inactive active]
  def index
    @streamers = StreamerProfile.all
  end

  def show; end

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
      render :new, alert: "Erro ao criar #{t(:streamer_profile, scope: 'activerecord.models')}!"
    end
  end

  def edit
    # O Rubocop apita aqui porque poderia ser "current_streamer" ao invés do _id, e entra num loop com Guard Clause
    unless @streamer_profile.owner?(current_streamer_id = current_streamer.id)
      redirect_to root_path, alert: "Você só pode editar o seu #{t(:streamer_profile, scope: 'activerecord.models')}!"
    end
  end

  def update
    # O Rubocop apita aqui porque poderia ser "current_streamer" ao invés do _id, e entra num loop com Guard Clause
    if !@streamer_profile.owner?(current_streamer_id = current_streamer.id)
      redirect_to root_path, alert: "Você só pode editar o seu #{t(:streamer_profile, scope: 'activerecord.models')}!"
    elsif @streamer_profile.update(streamer_profile_params)
      redirect_to @streamer_profile, notice: 'Perfil atualizado com sucesso!'
    else
      render :edit, alert: "Erro ao atualizar #{t(:streamer_profile, scope: 'activerecord.models')}!"
    end
  end

  def inactive
    redirect_to @streamer_profile, notice: t('.success') if @streamer_profile.inactive!
  end

  def active
    redirect_to @streamer_profile, notice: t('.success') if @streamer_profile.active!
  end

  private

  def find_profile
    @streamer_profile = StreamerProfile.find(params[:id])
  end

  def streamer_profile_exists?
    !StreamerProfile.find_by(streamer: current_streamer).nil?
  end

  def streamer_profile_params
    params.require(:streamer_profile).permit(:name, :description, :facebook,
                                             :instagram, :twitter,
                                             :streamer_id, :avatar)
  end
end
