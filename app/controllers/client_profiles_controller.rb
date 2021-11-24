class ClientProfilesController < ApplicationController
  before_action :authenticate_client!, only: %i[create new]
  before_action :authenticate_client_or_admin!, only: %i[show]
  before_action :check_if_profile_is_valid, only: %i[show]
  before_action :client_is_owner!, only: %i[edit update]
  def create
    @client_profile = current_client.build_client_profile(client_profile_params)
    if client_profile_exists?
      redirect_to current_client.client_profile, alert: 'Perfil já existente!'
    elsif @client_profile.save
      redirect_to @client_profile, notice: 'Perfil criado com sucesso!'
    else
      flash[:alert] = "Erro ao criar #{t(:client_profile, scope: 'activerecord.models')}!"
      render :new
    end
  end

  def new
    @client_profile = ClientProfile.new
    redirect_to current_client.client_profile, alert: 'Perfil já existente!' if client_profile_exists?
  end

  def show
    @client_profile = ClientProfile.find(params[:id])
  end

  def edit
    @client_profile = ClientProfile.find(params[:id])
  end

  def update
    @client_profile = ClientProfile.find(params[:id])

    if @client_profile.update(update_client_profile_params)
      redirect_to @client_profile, notice: 'Perfil atualizado com sucesso!'
    else
      flash[:alert] = "Erro ao atualizar #{t(:client_profile, scope: 'activerecord.models')}!"
      render :edit
    end
  end

  private

  def client_profile_exists?
    ClientProfile.find_by(client: current_client).present?
  end

  def check_if_profile_is_valid
    redirect_to new_client_profile_path unless current_client&.client_profile?
  end

  def client_is_owner!
    @client_profile = ClientProfile.find(params[:id])
    return if @client_profile.owner?(current_client)

    redirect_to root_path, alert: "Você só pode editar o seu #{t(:client_profile, scope: 'activerecord.models')}!"
  end

  def client_profile_params
    params.require(:client_profile).permit(:full_name, :social_name, :birth_date,
                                           :cpf, :cep, :city, :state, :age_rating,
                                           :residential_address,
                                           :residential_number, :photo)
  end

  def update_client_profile_params
    params.require(:client_profile).permit(:full_name, :social_name, :birth_date,
                                           :cep, :city, :state, :age_rating,
                                           :residential_address,
                                           :residential_number, :photo)
  end
end
