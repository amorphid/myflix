class QueuedVideosController < ApplicationController
  before_filter :authorize

  def index
    @videos = current_user.videos
  end
end
