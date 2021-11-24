class Video < ApplicationRecord
  validates :name, :description, :link, :name_game, :duration, presence: true, on: :create
  validates :feed_back, presence: true, if: :refused?
  validate :explaining_duration_patterns
  belongs_to :streamer
  
  enum status: { pending: 0, approved: 1, refused: 2 }

  def reproved_with_feedback?
    refused? && feed_back_in_database.present?
  end
  
  def explaining_duration_patterns
    errors.add(:duration, 'Deve inserir minutos e segundos. Exemplo 139:59 (139 minutos 59 segundos)') if duration && duration.size > 6
  end
end
