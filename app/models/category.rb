class Category < ActiveRecord::Base
  has_many :video_categories
  has_many :videos, through: :video_categories

  validates :title, presence: true

  def recent_videos
    videos.order("created_at DESC").limit(6)
  end
end
