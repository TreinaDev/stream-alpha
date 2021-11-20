class GameCategory < ApplicationRecord
  belongs_to :admin

  validates :name, uniqueness: true
  validates :name, presence: true
end
