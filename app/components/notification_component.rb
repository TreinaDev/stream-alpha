# app/components/notification_component.rb

# frozen_string_literal: true

# @param type [String] Classic notification type `error`, `alert` and `info` + custom `success`
# @param data [String, Hash] `String` for backward compatibility,
#   `Hash` for the new functionality `{title: '', body: '', timeout: 5, countdown: false,
#   action: { url: '', method: '', name: ''}}`.
#   The `title` attribute for `Hash` is mandatory.
class NotificationComponent < ViewComponent::Base
  def initialize(type:, data:)
    super
    @type = type
    @data = prepare_data(data)
    @bg_color = bg_color
    @text_color = text_color
    @boder_color = boder_color
    @data[:timeout] ||= 3
  end

  private

  def boder_color
    case @type
    when 'notice'
      'border-green-700'
    when 'error'
      'border-red-700'
    when 'alert'
      'border-red-700'
    else
      'border-gray-700'
    end
  end

  def bg_color
    case @type
    when 'notice'
      'bg-green-100'
    when 'alert'
      'bg-red-100'
    when 'error'
      'bg-red-100'
    else
      'bg-gray-100'
    end
  end

  def text_color
    case @type
    when 'notice'
      'text-green-700'
    when 'error' || 'alert'
      'text-red-700'
    else
      'text-gray-700'
    end
  end

  def prepare_data(data)
    case data
    when Hash
      data
    else
      { title: data }
    end
  end
end
