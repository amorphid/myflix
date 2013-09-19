class UpdatePritotyForEachQueuedVideo
  attr_reader :count,
              :queued_videos_data,
              :result

  def initialize(params_queued_videos)
    @queued_videos_data = params_queued_videos
    input_valid? ? run : (@result = false)
  end

  def input_valid?
    old_integers = queued_videos_data.map { |i| i[:priority].to_i }
    new_integers = old_integers.select { |i| i if i > 0 }
    old_integers == new_integers ? true : false
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
    sort_by_priority!
    normalize_priority!
    update_each_queued_video
    @result = begin
                update_each_queued_video
                true
              rescue
                false
              end
  end

  def success?
    result
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
