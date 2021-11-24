class Video < ApplicationRecord
  validates :name, :description, :link, :name_game, :duration, presence: true, on: :create
  belongs_to :streamer
  validate :explaining_duration_patterns

  def explaining_duration_patterns
    errors.add(:duration, 'Deve inserir minutos e segundos. Exemplo 139:59 (139 minutos 59 segundos)') if duration && duration.size > 6
  end
end
