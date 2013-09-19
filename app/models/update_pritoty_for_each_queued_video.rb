class UpdatePritotyForEachQueuedVideo
  attr_reader :count,
              :queued_videos_data

  def initialize(params_queued_videos)
    @queued_videos_data = params_queued_videos
    run
  end

  def normalize_priority!
    queued_videos_data.each_with_index do | queued_video_data, index |
      queued_video_data[:priority] = index + 1
    end
  end

  def sort_by_priority!
    queued_videos_data.sort_by! { |i| i[:priority] }
  end

  def run
    begin
      sort_by_priority!
      normalize_priority!
      update_each_queued_video
    rescue
      @success = false
    end
  end

  def success?
    @success ||= true
  end

  def update_each_queued_video
    QueuedVideo.transaction do
      queued_videos_data.each do |queued_video_data|
        queued_video = QueuedVideo.find(queued_video_data[:id])
        queued_video.update_attributes(priority: queued_video_data[:priority])
      end
    end
  end
end
