require "spec_helper"

describe FriendInvitesController do
  let(:friend_email) { "bob@example.cpom" }

  before { set_current_user }

  describe "POST create" do
    it "sends an email with email input" do
      post :create, email: friend_email
      expect(ActionMailer::Base.deliveries).not_to be_empty
    end

    it "redirects to invite page with email input" do
      post :create, email: friend_email
      expect(response).to redirect_to invite_path
    end

    it "redirects to invite page without email input" do
      post :create, email: ""
      expect(response).to redirect_to invite_path
    end

    it_behaves_like "require_sign_in" do
      let(:action) { post :create, email: friend_email }
    end
  end
end
