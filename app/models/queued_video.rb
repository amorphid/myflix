class QueuedVideo < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validates :priority, presence: true
  validates :user_id,  presence: true
  validates :video_id, presence: true

  validates_uniqueness_of :user_id, scope: :video_id

  def review
    Review.find_by(user_id: user_id, video_id: video_id)
  end
end
