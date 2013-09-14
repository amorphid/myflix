require "spec_helper"

describe QueuedVideosController do
  context "GET index" do
    it "sets @videos for authenticated users" do
      videos = Fabricate(:user).videos << Fabricate.times(2, :video)
      session[:user_id] = User.last.id
      get :index
      expect(assigns(:videos)).to match_array(videos)
    end

    it "redirects to root_path for unauthenticated users" do
      get :index
      expect(response).to redirect_to root_path
    end
  end
end
