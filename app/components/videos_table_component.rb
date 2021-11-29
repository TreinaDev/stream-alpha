# frozen_string_literal: true

class VideosTableComponent < ViewComponent::Base
  def initialize(videos:)
    @videos = videos
  end

end
