class Game < ApplicationRecord
  belongs_to :admin
  has_many :games_game_categories, dependent: :nullify
  has_many :game_categories, through: :games_game_categories

  validates :name, :game_category_ids, presence: true
  validates :name, uniqueness: true

  def game_categories_list_as_string
    return if game_categories.blank?

    string = ''
    game_categories.sort_by(&:name).each do |category|
      string += "#{category.name}, "
    end
    string.chomp(', ')
  end
end
