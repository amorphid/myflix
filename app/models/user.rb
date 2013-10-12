class User < ActiveRecord::Base
  has_secure_password

  has_one :follower

  has_many :user_followers
  has_many :reviews
  has_many :queued_videos
  has_many :videos, through: :queued_videos

  validates :email, presence: true, uniqueness: true
  validates :full_name, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :password_reset_token, presence: true

  def prioritized_queued_videos
    queued_videos.order("priority ASC")
  end
end
