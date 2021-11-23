class GamesGameCategory < ApplicationRecord
  belongs_to :game_category
  belongs_to :game
end
