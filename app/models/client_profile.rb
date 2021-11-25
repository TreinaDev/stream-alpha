class ClientProfile < ApplicationRecord
  belongs_to :client
  has_one_attached :photo

  validates :full_name, :social_name, :birth_date, :cpf, :cep, :city,
            :state, :residential_number, :residential_address, :age_rating,
            presence: true

  validate :must_include_a_surname, :correct_cpf_length, :correct_cep_length
  validate :acceptable_photo

  def owner?(current_client = nil)
    return current_client == client if current_client
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
end
