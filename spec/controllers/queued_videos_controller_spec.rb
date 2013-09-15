require "spec_helper"

describe QueuedVideosController do
  describe "POST create" do
    context "authenticated users" do
      let(:user)  { Fabricate(:user)  }
      let(:video) { Fabricate(:video) }

      before do
        request.env["HTTP_REFERER"] = "http://test.com/referring_url"
        session[:user_id] = user.id
      end

      it "creates a queued video w/ unique inputs" do
        post :create_or_destroy, video_id: video.id
        expect(QueuedVideo.count).to eq(1)
      end

      it "redirects to request.referrer w/ unique inputs" do
        post :create_or_destroy, video_id: video.id
        expect(response).to redirect_to @request.referrer
      end

      it "destroys a queued video w/ duplicate inputs" do
        Fabricate(:queued_video, user_id: user.id, video_id: video.id)
        post :create_or_destroy, video_id: video.id
        expect(QueuedVideo.count).to eq(0)
      end

      it "redirects to request.referrer w/ duplicate inputs" do
        Fabricate(:queued_video, user_id: user.id, video_id: video.id)
        post :create_or_destroy, video_id: video.id
        expect(response).to redirect_to request.referrer
      end
    end

    context "unauthenticated users" do
      it "redirects to root_path for unauthenticated users" do
        post :create_or_destroy, video: Fabricate(:video)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "GET index" do
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
