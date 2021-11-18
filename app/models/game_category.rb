class GameCategory < ApplicationRecord
  belongs_to :admin
  has_many :videos, dependent: :nullify

  validates :name, uniqueness: true
  validates :name, presence: true
end
