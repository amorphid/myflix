class FollowersController < ApplicationController
  before_action :authorize, only: [:create]

  def create
    follower = Follower.find_or_create_by(user_id: current_user.id)
    user     = User.find(params[:user_id])
    follower.users << user
    flash[:success] = "You are now following " + user.full_name
    redirect_to user_path(user)
  end
end
