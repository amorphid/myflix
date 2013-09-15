class QueuedVideosController < ApplicationController
  before_filter :authorize

  def create_or_destroy
    video = Video.find(params[:video_id])
    queued_video = QueuedVideo.find_or_initialize_by(
                    user_id: current_user.id, video_id: video.id)

    if queued_video.new_record?
      queued_video.save
      redirect_to :back, flash: {
        success: video.title + " successfully added to your queue" }
    else
      queued_video.destroy
      redirect_to :back, flash: {
        success: video.title + " successfully removed frmo your queue" }
    end
  end

  def index
    @videos = current_user.videos
  end
end
