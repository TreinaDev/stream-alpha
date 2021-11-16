class ClientProfilesController < ApplicationController
  before_action :check_if_profile_is_valid, only: %i[show]

  def create
    @client_profile = ClientProfile.new(client_profile_params)
    @client_profile.client = current_client
    if @client_profile.save
      redirect_to client_profile_path(@client_profile), notice: 'Perfil criado com sucesso!'
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
    redirect_to new_client_profile_path if current_client && current_client.client_profile.nil?
  end

  def client_profile_params
    params.require(:client_profile).permit(:full_name, :social_name, :birth_date,
                                           :cpf, :cep, :city, :state, :age_rating,
                                           :residential_address,
                                           :residential_number)
  end
end
