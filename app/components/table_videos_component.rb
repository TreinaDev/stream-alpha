# frozen_string_literal: true

class TableVideosComponent < ViewComponent::Base
  def initialize(videos:)
    @videos = videos
  end
end
