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
    @params_queued_videos = params[:queued_videos].values

    begin
      update_queued_video_priority
      redirect_to my_queue_path, flash: { success: "Queue successfully updated" }
    rescue
      redirect_to my_queue_path, flash: { error: "Please only enter positive integers for video priorities" }
    end
  end

private

  def count_plus_one
    @count += 1
  end

  def update_queued_video_priority
    @params_queued_videos.sort_by! { |i| i[:priority] }

    set_count
    QueuedVideo.transaction do
      @params_queued_videos.each do |params_queued_video|
        queued_video = QueuedVideo.find(params_queued_video[:id])
        queued_video.priority = count_plus_one
        queued_video.save
      end
    end
  end

  def queued_video_count_plus_1
    current_user.queued_videos.count + 1
  end

  def set_count
    @count = 0
  end

  def set_video
    @video = Video.find(params[:video_id])
  end
end
