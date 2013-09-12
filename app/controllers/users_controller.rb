class UsersController < ApplicationController
  def create
    @user = User.new(params_user)

    if @user.save
      redirect_to sign_in_path, flash: { success: "You have successfully signed up" }
    else
      render "new"
    end
  end

  def new
    if current_user
      redirect_to home_path, flash: { alert: "You already have an account" }
    else
      @user = User.new
    end
  end

private

  def params_user
    params[:user].permit(:full_name, :email, :password, :password_confirmation)
  end
end
