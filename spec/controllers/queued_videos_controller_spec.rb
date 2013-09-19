require "spec_helper"

describe QueuedVideosController do
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
      session[:user_id] = Fabricate(:user).id
      queued_videos = Fabricate.times(2, :queued_video_with_1_user)
      get :index
      expect(assigns(:queued_videos)).to match_array(queued_videos)
    end

    it "redirects to root_path for unauthenticated users" do
      get :index
      expect(response).to redirect_to root_path
    end
  end

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

  describe "POST update_all" do
    context "user signed in" do
      let(:queued_video_1) { Fabricate(:queued_video, priority: 1) }
      let(:queued_video_2) { Fabricate(:queued_video, priority: 2) }
      let(:queued_video_3) { Fabricate(:queued_video, priority: 3) }

      before do
        session[:user_id] = Fabricate(:user).id
      end

      it "updates all videos by priority" do
        params_for_post = { queued_video_1: { id: queued_video_1.id, priority: 3 },
                            queued_video_2: { id: queued_video_2.id, priority: 2 },
                            queued_video_3: { id: queued_video_3.id, priority: 1 } }

        post :update_all, queued_videos: params_for_post

        expect(QueuedVideo.find(queued_video_1.id).priority).to eq (3)
        expect(QueuedVideo.find(queued_video_2.id).priority).to eq (2)
        expect(QueuedVideo.find(queued_video_3.id).priority).to eq (1)
      end
    end
  end
end
