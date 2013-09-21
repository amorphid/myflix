class QueueItemsUpdate
  attr_reader :error,
              :queued_videos_data

  def initialize(params_queued_videos = [])
    @queued_videos_data = params_queued_videos
    sanitize_user_input

    if error.blank?
      sort_by_priority!
      normalize_priorities!
      update_queued_videos
    end
  end

  def error?(error = error)
    true unless error.blank?
  end

  def normalize_priorities!(priorities = queued_videos_data)
    priorities.each_with_index do | priorities, index |
      priorities[:priority] = index + 1
    end
  end

  def sanitize_user_input(queued_videos_data = queued_videos_data)
    please_no_nils = queued_videos_data.map do |i|
                       case i[:priority]
                       when /\d+/        then i # positive inteer
                       when /-\d+/       then i # negative integer
                       when /\d+[.]\d+/  then i # positive float
                       when /-\d+[.]\d+/ then i # positive float
                       else nil
                       end
                     end

    if please_no_nils.include? nil
      @error = "For video priorities, integers and floats only pleae."
    end
  end

  def sort_by_priority!(priorities = queued_videos_data)
    priorities.sort_by! { |i| i[:priority] }
  end

  def update_queued_videos(queued_videos_data = queued_videos_data)
    QueuedVideo.transaction do
      queued_videos_data.each do |queued_video_data|
        queued_video = QueuedVideo.find(queued_video_data[:id])
        queued_video.update_attributes!(priority: queued_video_data[:priority])
      end
    end
  end
end
