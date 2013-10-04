class Follower < ActiveRecord::Base
  belongs_to :user

  has_many :user_followers
  has_many :users, through: :user_followers

  validates :user_id, presence: true
end
