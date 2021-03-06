class ClientProfile < ApplicationRecord
  belongs_to :client
  has_one_attached :photo
  has_one :customer_payment_method, dependent: :destroy
  has_many :credit_card_settings, through: :customer_payment_method
  validates :full_name, :social_name, :birth_date, :cpf, :cep, :city,
            :state, :residential_number, :residential_address, :age_rating,
            presence: true

  validate :must_include_a_surname, :correct_cpf_length, :correct_cep_length
  validate :correct_cpf_sequence, if: :cpf
  validate :correct_birth_date, if: :birth_date
  validate :acceptable_photo

  enum client_token_status: { pending: 5, accepted: 10 }

  def owner?(current_client = nil)
    return current_client == client if current_client
  end

  def register_client_api(current_client)
    response = faraday_client_creation_call

    case response.status
    when 500, 422, 401
      pending!
    when 201
      current_client.client_profile.token = JSON.parse(response.body, simbolize_names: true)[0]['customer']['token']
      accepted!
    end
  end

  def register_client_boleto_and_pix_payment_method(payment_method, type_token)
    response = faraday_boleto_and_pix_creation_call(payment_method, type_token)
    case response.status
    when 500, 422, 421
      nil
    when 201
      get_token(response, payment_method)
    end
  end

  private

  def correct_birth_date
    errors.add(:birth_date, "deve ser anterior a #{I18n.l 18.years.ago.to_date}") if birth_date.after? 18.years.ago
  end

  def cpf_final_digits
    d1 = 0
    d2 = 0

    cpf.each_char.with_index do |number, index|
      d1 += number.to_i * (10 - index) * 10 if index < 9
      d2 += number.to_i * (11 - index) * 10 if index < 10
    end

    [d1 % 11, d2 % 11]
  end

  def correct_cpf_sequence
    return if cpf.index(cpf_final_digits.join).eql? 9

    errors.add(:cpf, 'com sequência de dígitos invalida')
  end

  def correct_cep_length
    errors.add(:cep, I18n.t('digits', scope: 'activerecord.errors.messages', size: '8')) if cep && cep.chars.length != 8
  end

  def get_token(response, payment_method)
    case payment_method
    when 'pix'
      customer_payment_method.pix_token = JSON.parse(response.body,
                                                     simbolize_names: true)['customer_payment_method']['token']
    when 'boleto'
      customer_payment_method.boleto_token = JSON.parse(response.body,
                                                        simbolize_names: true)['customer_payment_method']['token']
    end
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

  def faraday_client_creation_call
    Faraday.post('http://localhost:4000/api/v1/customers',
                 { name: full_name, cpf: cpf },
                 { companyToken: Rails.configuration.payment_api['company_auth_token'] })
  end

  def faraday_boleto_and_pix_creation_call(payment_method, type_token)
    Faraday.post('http://localhost:4000/api/v1/customer_payment_methods',
                 {
                   customer_payment_method: {
                     customer_token: token,
                     type_of: payment_method,
                     payment_setting_token: type_token
                   }
                 },
                 { companyToken: Rails.configuration.payment_api['company_auth_token'] })
  end
end
