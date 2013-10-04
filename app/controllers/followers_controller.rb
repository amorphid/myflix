class FollowersController < ApplicationController
  before_action :authorize

  def create
    follower = Follower.find_or_create_by(user_id: current_user.id)
    user     = User.find(params[:user_id])
    follower.users << user
    flash[:success] = "You are now following " + user.full_name
    redirect_to :back
  end

  def destroy
    follower      = Follower.find(params[:id])
    user_follower = UserFollower.find_by(follower_id: follower.id,
                                         user_id:     params[:user_id])
    user_follower.destroy
    follower.destroy if follower.users.count == 0
    redirect_to :back
  end
end
