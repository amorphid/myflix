class Video < ActiveRecord::Base
  has_many :video_categories
  has_many :categories, through: :video_categories

  validates :title, presence: true
  validates :description, presence: true
  validates :small_cover_url, presence: true
  validates :large_cover_url, presence: true
end
