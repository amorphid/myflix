class QueuedVideosController < ApplicationController
  before_filter :authorize

  before_action :set_video, only: [:create, :destroy]

  def create
    QueuedVideo.create(user_id: current_user.id, video_id: @video.id)
    redirect_to :back, flash: { success: @video.title + " successfully added to your queue" }
  end

  def destroy

    queued_video = QueuedVideo.find_by(user_id: current_user.id, video_id: @video.id)
    queued_video.destroy
    redirect_to :back, flash: { success: @video.title + " successfully removed frmo your queue" }
  end

  def index
    @videos = current_user.videos
  end

  def set_video
    @video = Video.find(params[:video_id])
  end
end
