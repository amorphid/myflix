class QueuedVideosController < ApplicationController
  before_filter :authorize

  before_action :set_video, only: [:create, :destroy]

  def create
    QueuedVideo.create(user_id: current_user.id, video_id: @video.id)
    redirect_to :back, flash: { success: @video.title + " successfully added to your queue" }
  end

  def destroy
    QueuedVideo.delete(params[:id])
    redirect_to :back, flash: { success: @video.title + " successfully removed from your queue" }
  end

  def index
    @queued_videos = current_user.queued_videos
  end

  def update_all
    binding.pry
  end

private

  def set_video
    @video = Video.find(params[:video_id])
  end
end
