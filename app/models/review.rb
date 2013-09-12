class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validates :description, presence: true
  validates :rating, presence: true
  validates :user_id, presence: true
  validates :video_id, presence: true
end
