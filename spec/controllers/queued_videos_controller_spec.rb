require "spec_helper"

describe QueuedVideosController do
  context "GET index" do
    it "sets @videos for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      videos = Fabricate.times(2, :video)
      get :index
      expect(assigns(:videos)).to eq(User.last.videos)
    end

    it "redirects to root_path for unauthenticated users" do
      get :index
      expect(response).to redirect_to root_path
    end
  end
end
