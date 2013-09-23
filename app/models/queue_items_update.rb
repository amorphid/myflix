class QueueItemsUpdate
  attr_reader :error,
              :reviews_data,
              :queued_videos_data,
              :user

  def initialize(params = [], user)
    @queued_videos_data = params[:queued_videos]
    @reviews_data       = params[:reviews]
    @user               = user
    # binding.pry
    sanitize_user_input

    if error.blank?
      sort_by_priority!
      normalize_priorities!
      update_queued_videos
      update_reviews
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
      i if i[:priority].to_i.to_s == i[:priority] ||
           i[:priority].to_f.to_s == i[:priority]
   end

    if please_no_nils.include? nil
      @error = "For video priorities, integers and floats only please."
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

  def update_reviews(reviews_data = reviews_data)
    Review.transaction do
      reviews_data.each do |review_data|
        review = Review.find_by(user_id: user.id, video_id: review_data[:video_id])
        review.update_attributes!(rating: review_data[:rating])
      end
    end
  end
end
