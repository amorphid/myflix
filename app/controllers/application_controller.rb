class ApplicationController < ActionController::Base
  protect_from_forgery

  def authorize
    redirect_to sign_in_path, alert: "You must be logged in" if current_user.nil?
  end

  def current_user
    if User.exists? session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      session[:user_id] = nil
    end
  end

  helper_method :current_user
end
