class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to videos_path, flash: { success: "You have successfully logged in" }
    else
      redirect_to sign_in_path, flash: { error: "Invalid username and/or password" }
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, flash: { success: "You have successfully logged out" }
  end

  def new
    if current_user
      redirect_to home_path, flash: { alert: "You are already signed in"}
    end
  end
end
