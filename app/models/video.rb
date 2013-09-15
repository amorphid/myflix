class Video < ActiveRecord::Base
  has_many :categories, through: :video_categories
  has_many :queued_videos
  has_many :reviews, -> { order('created_at DESC') }
  has_many :video_categories

  validates :title, presence: true
  validates :description, presence: true
  validates :small_cover_url, presence: true
  validates :large_cover_url, presence: true

  def average_rating
    unless reviews.empty?
      sum = reviews.sum("rating")
      average = sum.to_f / reviews.count
      average.round(1)
    else
      0.0
    end
  end

  def in_queue?(user)
    QueuedVideo.exists?(user_id: user.id, video_id: self.id) ? true : false
  end

  def self.search_by_title(title)
    unless title.blank?
      Video.where("title LIKE :title", title: "%" + title + "%")
    else
      []
    end
  end
end
