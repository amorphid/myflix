class QueuedVideo < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  before_save :priority_is_positive_integer?

  validates :priority, presence: true
  validates :user_id,  presence: true
  validates :video_id, presence: true

  validates_uniqueness_of :user_id, scope: :video_id

  def priority_is_positive_integer?
    if priority.is_a? Integer
      priority > 0 ? true : false
    else
      false
    end
  end
end
