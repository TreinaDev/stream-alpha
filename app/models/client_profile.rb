class ClientProfile < ApplicationRecord
  belongs_to :client

  validates :full_name, :social_name, :birth_date, :cpf, :cep, :city,
            :state, :residential_number, :residential_address, :age_rating,
            presence: { message: 'é obrigatório(a)' }
end
