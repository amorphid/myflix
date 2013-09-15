require "spec_helper"

describe QueuedVideosController do
  describe "POST create" do
    context "authenticated users" do
      before { session[:user_id] = Fabricate(:user).id }

      it "Creates a queued video " do
        post :create, video_id: Fabricate(:video).id
        expect(QueuedVideo.count).to eq(1)
      end

      it "Destroys a queued video for authenticated users" do
        video = Fabricate(:video)
        Fabricate(:queued_video, user_id: User.last.id, video_id: video.id)
        post :create, video_id: video.id
        expect(QueuedVideo.count).to eq(0)
      end
    end

    context "unauthenticated users" do
      it "redirects to root_path for unauthenticated users" do
        post :create, video: Fabricate(:video)
        expect(response).to redirect_to root_path
      end
    end
  end

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
