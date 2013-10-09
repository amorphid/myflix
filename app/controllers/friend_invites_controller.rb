class FriendInvitesController < ApplicationController
  before_action :authorize

  def create
    unless params[:email].blank?
      @user = User.new(email: params[:email], full_name: params[:full_name])
      AppMailer.friend_invite(@user, params[:invitation_message]).deliver
      flash[:success] = "Friend invited.  Invite another!"
      redirect_to invite_path
    else
      flash[:error] = "Email may not be blank"
      redirect_to invite_path
    end
  end

  def new
  end
end
