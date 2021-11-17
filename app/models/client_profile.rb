class ClientProfile < ApplicationRecord
  belongs_to :client

  validates :full_name, :social_name, :birth_date, :cpf, :cep, :city,
            :state, :residential_number, :residential_address, :age_rating,
            presence: true

  validate :must_include_a_surname, :correct_cpf_length, :correct_cep_length

  private

  def correct_cep_length
    errors.add(:cep, 'deve ter 8 dígitos') if cep && cep.chars.length != 8
  end

  def correct_cpf_length
    errors.add(:cpf, 'deve ter 11 dígitos') if cpf && cpf.chars.length != 11
  end

  def must_include_a_surname
    errors.add(:full_name, 'deve incluir um sobrenome') if full_name && full_name.split.length < 2
  end
end
