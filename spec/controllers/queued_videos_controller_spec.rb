require "spec_helper"

describe QueuedVideosController do
  describe "POST create" do
    context "for an authenticated user" do
      let(:user)  { Fabricate(:user)  }
      let(:video) { Fabricate(:video) }

      before do
        request.env["HTTP_REFERER"] = "http://test.com/referring_url"
        session[:user_id] = user.id
      end

      it "creates a queued video" do
        post :create, video_id: video.id
        expect(QueuedVideo.count).to eq(1)
      end

      it "redirects to request.referrer" do
        post :create, video_id: video.id
        expect(response).to redirect_to @request.referrer
      end
    end

    context "for an unauthenticated user" do
      it "redirects to root_path" do
        post :create, video_id: Fabricate(:video).id
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "DELETE destroy" do
    context "for an authenticated user" do
      let(:user)          { Fabricate(:user)  }
      let(:video)         { Fabricate(:video) }
      let(:queued_video)  { Fabricate(:queued_video, user_id: user.id, video_id: video.id) }

      before do
        request.env["HTTP_REFERER"] = "http://test.com/referring_url"
        session[:user_id] = user.id
      end

      it "destroys a queued video" do
        delete :destroy, id: queued_video.id, video_id: video.id
        expect(QueuedVideo.count).to eq(0)
      end

      it "redirects to request.referrer" do
        delete :destroy, id: queued_video.id, video_id: video.id
        expect(response).to redirect_to request.referrer
      end
    end

    context "for an unauthenticated user" do
      it "redirects to root_path" do
        delete :destroy, id: "", video_id: ""
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
