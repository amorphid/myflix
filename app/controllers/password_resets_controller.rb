class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user
      # @user.update_attributes(password_reset_token: set_password_reset_token)
      AppMailer.password_reset(@user).deliver
      redirect_to confirm_password_reset_path
    else
      flash[:error] = "Invalid email"
      redirect_to forgot_password_path
    end
  end

  def update
    user = User.find_by(password_reset_token: params[:password_reset_token])

    user.password              = params[:password]
    user.password_confirmation = params[:password_confirmation]
    user.password_reset_token  = set_password_reset_token

    if user.save
      flash[:success] = "Password has been reset & you may login"
      redirect_to sign_in_path
    elsif params[:password].length < 1 || params[:password_confirmation].length < 1
      flash[:error] = "Passwords must be 1 or more characters"
      redirect_to reset_password_url(password_reset_token: params[:password_reset_token])
    else
      flash[:error] = "Passwords must match"
      redirect_to reset_password_url(password_reset_token: params[:password_reset_token])
    end
  end

  def edit
    @user = User.find_by(password_reset_token: params[:password_reset_token])
  end

private

  def set_password_reset_token
    SecureRandom.urlsafe_base64
  end
end
