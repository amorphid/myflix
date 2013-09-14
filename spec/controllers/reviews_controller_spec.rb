require "spec_helper"

describe ReviewsController do
  context "POST create" do
    it "create a video w/ valid input for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      review_attr = Fabricate.attributes_for(:review, video_id: video.id)
      post :create, video_id: video.id, review: review_attr
      expect(Review.count).to eq(1)
    end

    it "redirects to video_path(video) w/ valid input for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      review_attr = Fabricate.attributes_for(:review, video_id: video.id)
      post :create, video_id: video.id, review: review_attr
      expect(response).to redirect_to video_path(video)
    end

    it "redirects to video_path(video) w/ invalid input for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      post :create, video_id: video.id, review: {}
      expect(response).to redirect_to video_path(video)
    end

    it "redirects to root_path for unauthenticated users" do
      video = Fabricate(:video)
      post :create, video_id: video.id, review: {}
      expect(response).to redirect_to root_path
    end
  end
end
