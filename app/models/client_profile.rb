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
    response = faraday_call(current_client)

    case response.status
    when 500, 422, 401
      pending!
    when 201
      current_client.client_profile.token = JSON.parse(response.body, simbolize_names: true)[0]['token']
      accepted!
    end
  end

  private

  def correct_cep_length
    errors.add(:cep, I18n.t('digits', scope: 'activerecord.errors.messages', size: '8')) if cep && cep.chars.length != 8
  end

  def correct_cpf_length
    return unless cpf && cpf.chars.length != 11

    errors.add(:cpf, I18n.t('digits', scope: 'activerecord.errors.messages', size: '11'))
  end

  def must_include_a_surname
    errors.add(:full_name, 'deve incluir um sobrenome') if full_name && full_name.split.length < 2
  end

  def acceptable_photo
    return unless photo.attached?
    return unless photo.byte_size > 2.megabyte

    errors.add(:photo, I18n.t('file_too_large', scope: 'activerecord.errors.messages', size: '2Mb'))
  end

  def faraday_call(current_client)
    Faraday.post('http://localhost:4000/api/v1/customers',
                 { name: current_client.client_profile.full_name, cpf: current_client.client_profile.cpf },
                 { companyToken: Rails.configuration.payment_api['company_auth_token'] })
  end
end
