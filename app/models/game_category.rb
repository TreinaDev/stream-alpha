class GameCategory < ApplicationRecord
  belongs_to :admin
  has_many :video
  has_many :game_subcategory

  validates :name, uniqueness: true
  validates :name, presence: true
end
