require "spec_helper"

describe VideosController do
  describe "GET index" do
    it "sets @videos for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      categories = Fabricate.times(2, :category) { videos(count: 2) }
      get :index
      expect(assigns(:categories)).to eq(categories.sort)
    end

    it "redirects to root_path for unauthenticaed users" do
      categories = Fabricate.times(2, :category) { videos(count: 2) }
      get :index
      expect(response).to redirect_to root_path
    end
  end

  describe "POST search" do
    it "sets @videos for an authenticated user" do
      session[:user_id] = Fabricate(:user).id
      title = Faker::Lorem.words(2).join(" ")
      videos = Fabricate.times(2, :video, title: title)
      post :search, title: title
      expect(assigns(:videos)).to eq(videos)
    end

    it "redirects to root_path an unauthenticaed user" do
      post :search, title: Faker::Lorem.words(2).join(" ")
      expect(response).to redirect_to root_path
    end
  end

  describe "GET show" do
    context "for an authenticated user" do
      let(:user)  { Fabricate(:user)  }
      let(:video) { Fabricate(:video) }

      before do
        session[:user_id] = user.id
      end

      it "sets @video" do
        get :show, id: video.id
        expect(assigns(:video)).to eq(video)
      end

      it "sets @queued_video if video in queue" do
        queued_video = Fabricate(:queued_video, user_id: user.id, video_id: video.id)
        get :show, id: video.id
        expect(assigns(:queued_video)).to eq(queued_video)
      end

      it "it does not set @queued_video for un-queueed video" do
        get :show, id: video.id
        expect(assigns(:queued_video)).to eq(nil)
      end
    end

    context "for an unauthenticated user" do
      it "redirects to root_path" do
        video = Fabricate(:video)
        get :show, id: video.id
        expect(response).to redirect_to root_path
      end
    end
  end
end
