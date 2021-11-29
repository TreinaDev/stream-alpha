# frozen_string_literal: true

class GameCategoryCardComponent < ViewComponent::Base
  with_collection_parameter :game_category
  def initialize(game_category:, color: 'gray')
    @game_category = game_category
    @color = color
  end

end
