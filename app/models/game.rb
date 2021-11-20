class Game < ApplicationRecord
  belongs_to :admin
  has_many :games_game_categories
  has_many :game_categories, through: :games_game_categories

  def game_categories_list_as_string
    if self.game_categories
      string = ''
      self.game_categories.each do |category|
        string += "#{category.name.to_s}, "
      end
      string[0..string.size-3]
    end
  end
end
