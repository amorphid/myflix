class QueuedVideosController < ApplicationController
  before_filter :authorize

  before_action :set_video, only: [:create, :destroy]

  def create
    QueuedVideo.create(user_id: current_user.id, video_id: @video.id, priority: queued_video_count_plus_1)
    redirect_to :back, flash: { success: @video.title + " successfully added to your queue" }
  end

  def destroy
    QueuedVideo.delete(params[:id])
    redirect_to :back, flash: { success: @video.title + " successfully removed from your queue" }
  end

  def index
    @queued_videos = current_user.prioritized_queued_videos
  end

  def update_all
    params_queued_videos = params[:queued_videos].values
    update = UpdatePritotyForEachQueuedVideo.new(params_queued_videos)

    if update.success?
      redirect_to my_queue_path, flash: { success: "Queue successfully updated" }
    else
      redirect_to my_queue_path, flash: { error: "Please only enter positive integers for video priorities" }
    end
  end

private

  def queued_video_count_plus_1
    QueuedVideo.count + 1
  end

  def set_video
    @video = Video.find(params[:video_id])
  end
end
