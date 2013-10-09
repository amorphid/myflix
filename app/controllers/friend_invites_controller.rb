class FriendInvitesController < ApplicationController
  before_action :authorize

  def create
    unless params[:email].blank?
      @user = User.new(email: params[:email])
      AppMailer.friend_invite(@user).deliver
      redirect_to invite_path
    else
      redirect_to invite_path
    end
  end

  def new
  end

  def show
    # sign up form for friend
  end

  def update
    # process sign up form for friend params
  end
end
