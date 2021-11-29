# frozen_string_literal: true

class LineComprasComponent < ViewComponent::Base
  def initialize(name:, value:)
    @name = name
    @value = value
  end

end
