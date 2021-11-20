class Game < ApplicationRecord
  belongs_to :admin
  has_many :games_game_categories
  has_many :game_categories, through: :games_game_categories

  validates :name, :game_category_ids, presence: true
  validates :name, uniqueness: true

  def game_categories_list_as_string
    if game_categories.present?
      string = ''
      game_categories.sort_by {|categories| categories.name}.each do |category|
        string += "#{category.name}, "
      end
      string[0..string.size-3]
    end
  end
end
