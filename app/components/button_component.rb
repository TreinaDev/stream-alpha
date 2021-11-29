# frozen_string_literal: true

# comments here
class ButtonComponent < ViewComponent::Base
  def initialize(text:, path: '/', method: :get, local: false, color: 'blue',
                 padding: 1)
    super
    @text = text
    @path = path
    @method = method
    @local = local
    @color = color
    @p = padding
  end
end
