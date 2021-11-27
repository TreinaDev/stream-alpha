class ClientProfile < ApplicationRecord
  belongs_to :client
  has_one_attached :photo

  validates :full_name, :social_name, :birth_date, :cpf, :cep, :city,
            :state, :residential_number, :residential_address, :age_rating,
            presence: true

  validate :must_include_a_surname, :correct_cpf_length, :correct_cep_length
  validate :acceptable_photo

  enum client_token_status: { pending: 5, accepted: 10 }

  def owner?(current_client = nil)
    return current_client == client if current_client
  end

  def register_client_api(current_client)
    response = Faraday.post('http://localhost:4000/api/v1/customer_registration/',
                            { name: current_client.client_profile.full_name, cpf: current_client.client_profile.cpf },
                            { company_token: SecureRandom.alphanumeric(20) })

    if response.status == 500 || response.status == 401
      pending!
    #elsif response.status == 422
    #  pending!
    elsif response.status == 200
      current_client.client_profile.token = JSON.parse(response.body, simbolize_names: true)[0]['token']
      accepted!
    end
  end

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

  def acceptable_photo
    return unless photo.attached?
    return unless photo.byte_size > 2.megabyte

    errors.add(:photo, I18n.t('photo.image_too_big', scope: 'activerecord.errors.models.client_profile.attributes'))
  end
end
