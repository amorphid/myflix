class FriendInvitesController < ApplicationController
  before_action :authorize

  def create
    unless params[:email].blank?
      @user = User.new(email: params[:email])
      AppMailer.friend_invite(@user).deliver
      flash[:success] = "Friend invited.  Invite another!"
      redirect_to invite_path
    else
      flash[:error] = "Email may not be blank"
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
