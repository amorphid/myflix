require "spec_helper"

describe FollowersController do
  let(:current_user)   { User.find(session[:user_id]) }
  let(:user_to_follow) { Fabricate(:user) }

  before { set_current_user }

  describe "POST create" do
    it "creates a follower if no follower exists" do
      post :create, user_id: user_to_follow.id
      expect(Follower.count).to eq(1)
    end

    it "does not create a follower if current_user already has one" do
      Follower.create(user_id: current_user.id)
      follower_count = Follower.count
      post :create, user_id: user_to_follow.id
      expect(Follower.count).to eq(follower_count)
    end

    it_behaves_like "require_sign_in" do
      let(:action) { post :create }
    end
  end
end
