class ClientProfile < ApplicationRecord
  belongs_to :client
  has_one_attached :photo

  validates :full_name, :social_name, :birth_date, :cpf, :cep, :city,
            :state, :residential_number, :residential_address, :age_rating,
            presence: true

  validate :must_include_a_surname, :correct_cpf_length, :correct_cep_length
  validate :acceptable_photo

  def owner?(current_client = false)
    return current_client == client if current_client
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

    if photo.byte_size > 2.megabyte
      errors.add(:photo, I18n.t('photo.image_too_big',
                                scope: 'activerecord.errors.models.'\
                                       'client_profile.attributes'))
    end
  end
end
