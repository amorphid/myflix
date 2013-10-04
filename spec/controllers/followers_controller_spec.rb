require "spec_helper"

describe FollowersController do
  let(:current_user)   { User.last }
  let(:user_to_follow) { Fabricate(:user) }

  before do
    request.env["HTTP_REFERER"] = "http://test.com/referring_url"
    set_current_user
  end

  describe "DELETE destroy" do
    it "deletes the UserFollower" do
      follower      = Follower.create(user_id: current_user.id)
      user_follower = UserFollower.create(follower_id: follower.id,
                                          user_id:     user_to_follow.id)
      delete :destroy, id: follower.id, user_id: user_to_follow.id
      expect(UserFollower.count).to eq(0)
    end

    it "does not delete a Follower with Users" do
      follower      = Follower.create(user_id: current_user.id)
      UserFollower.create(follower_id: follower.id, user_id: current_user.id)
      user_follower = UserFollower.create(follower_id: follower.id,
                                          user_id:     user_to_follow.id)
      delete :destroy, id: follower.id, user_id: user_to_follow.id
      expect(Follower.count).to eq(1)
    end

    it "deletes a Follower with no users" do
      follower = Follower.create(user_id: current_user.id)
      follower.users << user_to_follow
      delete :destroy, id: follower.id, user_id: user_to_follow.id
      expect(Follower.count).to eq(0)
    end

    it "redirects to request.referrer" do
      post :create, user_id: user_to_follow.id
      expect(response).to redirect_to request.referrer
    end

    it_behaves_like "require_sign_in" do
      let(:action) { delete :destroy, id: current_user.id }
    end
  end

  describe "POST create" do
    it "creates a follower if no follower exists" do
      post :create, user_id: user_to_follow.id
      expect(Follower.count).to eq(1)
    end

    it "does not create a follower if current_user already has one" do
      Follower.create(user_id: current_user.id)
      post :create, user_id: user_to_follow.id
      expect(Follower.count).to eq(1)
    end

    it "redirects to request.referrer" do
      post :create, user_id: user_to_follow.id
      expect(response).to redirect_to request.referrer
    end

    it_behaves_like "require_sign_in" do
      let(:action) { post :create }
    end
  end
end
