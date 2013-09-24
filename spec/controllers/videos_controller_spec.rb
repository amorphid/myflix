require "spec_helper"

describe VideosController do

  before { set_current_user }

  describe "GET index" do
    it "sets @videos for authenticated users" do
      categories = Fabricate.times(2, :category) { videos(count: 2) }
      get :index
      expect(assigns(:categories)).to eq(categories.sort)
    end

    it_behaves_like "require_sign_in" do
      let(:action) { get :index }
    end
  end

  describe "POST search" do
    it "sets @videos for an authenticated user" do
      title = Faker::Lorem.words(2).join(" ")
      videos = Fabricate.times(2, :video, title: title)
      post :search, title: title
      expect(assigns(:videos)).to eq(videos)
    end

    it_behaves_like "require_sign_in" do
      let(:action) { post :search }
    end
  end

  describe "GET show" do
    let(:user)  { User.last         }
    let(:video) { Fabricate(:video) }

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

    it_behaves_like "require_sign_in" do
      let(:action) { get :show, id: video.id }
    end
  end
end
