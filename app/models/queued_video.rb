class QueuedVideo < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validates :user_id, presence: true
  validates :video_id, presence: true

  validates_uniqueness_of :user_id, scope: :video_id
end
