class UserFollower < ActiveRecord::Base
  belongs_to :follower
  belongs_to :user
end
