# frozen_string_literal: true

class CardComponent < ViewComponent::Base
  def initialize(name:, color: 'white', value:, mode:, type: 1, icon: "")
    @name = name
    @color = color
    @value = value
    @mode = mode
    @type = type
    @icon = icon
  end

end
