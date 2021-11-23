class GameCategory < ApplicationRecord
  belongs_to :admin
  has_many :games_game_categories, dependent: :nullify
  has_many :games, through: :games_game_categories

  validates :name, uniqueness: true
  validates :name, presence: true
end
