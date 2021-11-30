# frozen_string_literal: true

class LinePushaseComponent < ViewComponent::Base
  def initialize(name:, value:)
    @name = name
    @value = value
  end

end
