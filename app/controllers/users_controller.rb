class UsersController < ApplicationController
  before_action :authorize, only: [:index, :show]

  def create
    @user = User.new(params_user)
    @user.password_reset_token = set_password_reset_token

    if @user.save
      AppMailer.send_welcome_on_sign_up(@user).deliver
      redirect_to sign_in_path, flash: { success: "You have successfully signed up" }
    else
      render "new"
    end
  end

  def forgot_password
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

  def reset_password
    binding.pry
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

  def set_password_reset_token
    SecureRandom.urlsafe_base64
  end
end
