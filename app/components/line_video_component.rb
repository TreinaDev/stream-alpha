# frozen_string_literal: true

class LineVideoComponent < ViewComponent::Base
  with_collection_parameter :video

  def initialize(video:)
    @video = video
    @color = set_color
  end

  def set_color
    case @video.status
    when 'approved'
      'green'
    when 'refused'
      'red'
    when 'pending'
      'gray'
    end
  end
end
