class User < ActiveRecord::Base
  has_secure_password

  has_many :reviews
  has_many :queued_videos
  has_many :videos, through: :queued_videos

  validates :email, presence: true, uniqueness: true
  validates :full_name, presence: true
  validates :password_digest, presence: true

  def prioritized_queued_videos
    queued_videos.order("priority ASC")
  end
end
