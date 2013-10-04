class UsersController < ApplicationController
  before_action :authorize, only: [:index, :show]

  def create
    @user = User.new(params_user)

    if @user.save
      redirect_to sign_in_path, flash: { success: "You have successfully signed up" }
    else
      render "new"
    end
  end

  def index
  end

  def new
    if current_user
      redirect_to home_path, flash: { alert: "You already have an account" }
    else
      @user = User.new
    end
  end

  def show
    @user = User.find(params[:id])

    if current_user.follower
      @user_follower = UserFollower.find_by(follower_id: current_user.follower.id,
                                            user_id: @user.id)
    end
  end

private

  def params_user
    params[:user].permit(:full_name, :email, :password, :password_confirmation)
  end
end
