class ClientProfilesController < ApplicationController
  before_action :authenticate_client!, only: %i[create new]
  before_action :authenticate_client_or_admin!, only: %i[show]
  before_action :check_if_profile_is_valid, only: %i[show]
  def create
    @client_profile = current_client.build_client_profile(client_profile_params)
    if @client_profile.save
      redirect_to @client_profile, notice: 'Perfil criado com sucesso!'
    else
      render :new
    end
  end

  def new
    @client_profile = ClientProfile.new
  end

  def show
    @client_profile = ClientProfile.find(params[:id])
  end

  private

  def check_if_profile_is_valid
    redirect_to new_client_profile_path unless current_client&.client_profile?
  end

  def client_profile_params
    params.require(:client_profile).permit(:full_name, :social_name, :birth_date,
                                           :cpf, :cep, :city, :state, :age_rating,
                                           :residential_address,
                                           :residential_number)
  end
end
