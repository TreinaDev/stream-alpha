class Video < ApplicationRecord
  validates :name, :description, :link, :name_game, :duration, presence: true, on: :create
  validates :feed_back, presence: true, if: :refused?
  validate :explaining_duration_patterns
  belongs_to :streamer
  has_one :duration
  accept_nested_attribute_for :duration
  
  enum status: { pending: 0, approved: 1, refused: 2 }

  def reproved_with_feedback?
    refused? && feed_back_in_database.present?
  end
  
  def explaining_duration_patterns
    time = duration.split ':'
    minutes = time[0].to_i
    seconds = time[1].to_i
    if duration && duration.chars.length > 6 && time[-3] != ':'
      errors.add(:duration, 'deve inserir minutos e segundos. Exemplo 139:59 (139 minutos 59 segundos)')
    elsif duration && minutes > 140
      errors.add(:duration, ': Maximo 139 minutos por video')
    elsif duration && seconds > 59 && seconds.to_s.size != 2
      errors.add(:duration, ': Segundos devem ser duass cifras de valor maximo 59.')
    end
  end
end
