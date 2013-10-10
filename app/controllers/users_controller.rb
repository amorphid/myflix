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
      @user = User.new(email: params[:email], full_name: params[:full_name])
    end
  end

  def request_password_reset
    @user = User.find_by(email: params[:email])

    if @user
      AppMailer.password_reset(@user).deliver
      redirect_to confirm_password_reset_path
    else
      flash[:error] = "Invalid email"
      redirect_to forgot_password_path
    end
  end

  def reset_password
    @user = User.find_by(password_reset_token: params[:password_reset_token])
  end

  def password_reset
    user = User.find_by(password_reset_token: params[:password_reset_token])

    if params[:password].length < 1 || params[:password_confirmation].length < 1
      flash[:error] = "Passwords must be 1 or more characters"
      redirect_to reset_password_url(password_reset_token: params[:password_reset_token])
    else
      user.password              = params[:password]
      user.password_confirmation = params[:password_confirmation]
      user.password_reset_token  = set_password_reset_token

      if user.save
        flash[:success] = "Password has been reset & you may login"
        redirect_to sign_in_path
      else
        flash[:error] = "Passwords must match"
        redirect_to reset_password_url(password_reset_token: params[:password_reset_token])
      end
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

  def set_password_reset_token
    SecureRandom.urlsafe_base64
  end
end
