class UpdatePritotyForEachQueuedVideo
  attr_reader :count,
              :params_queued_videos,
              :result

  def initialize(params_queued_videos)
    @count                = 0
    @params_queued_videos = params_queued_videos
    sort_params_queued_videos_by_priority
    input_valid? ? run : (@result = false)
  end

  def count_plus_one
    @count += 1
  end

  def input_valid?
    old_integers = params_queued_videos.map { |i| i[:priority].to_i }
    new_integers = old_integers.select { |i| i if i > 0 }
    old_integers == new_integers ? true : false
  end

  def sort_params_queued_videos_by_priority
    params_queued_videos.sort_by! { |i| i[:priority] }
  end

  def run
    @result = begin
                update_priority_for_each_queued_video
                true
              rescue
                false
              end
  end

  def success?
    result
  end

  def update_priority_for_each_queued_video
    QueuedVideo.transaction do
      params_queued_videos.each do |params_queued_video|
        queued_video = QueuedVideo.find(params_queued_video[:id])
        queued_video.priority = count_plus_one
        queued_video.save
      end
    end
  end
end
