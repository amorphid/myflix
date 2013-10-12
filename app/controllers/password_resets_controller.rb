class PasswordResetsController < ApplicationController
  def forgot_password
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
end
