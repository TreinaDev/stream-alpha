# frozen_string_literal: true

class LineClientComponent < ViewComponent::Base
  def initialize(name:, value:, status:, date:)
    @name = name
    @value = value
    @status = status
    @date = date
    @color = set_color
  end

  def set_color
    case @status
    when 'approved'
      'green'
    when 'pending'
      'yellow'
    when 'expired'
      'gray'
    when 'denied'
      'red'
    end
  end
end
