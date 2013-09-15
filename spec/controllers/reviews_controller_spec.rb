require "spec_helper"

describe ReviewsController do
  describe "POST create" do
    context "user signed in" do
      let(:video) { video = Fabricate(:video) }

      before do
        session[:user_id] = Fabricate(:user).id
      end

      it "create a review w/ valid input" do
        review_attr = Fabricate.attributes_for(:review, video_id: video.id)
        post :create, video_id: video.id, review: review_attr
        expect(Review.count).to eq(1)
      end

      it "redirects to video_path(video) w/ valid input" do
        review_attr = Fabricate.attributes_for(:review, video_id: video.id)
        post :create, video_id: video.id, review: review_attr
        expect(response).to redirect_to video_path(video)
      end

      it "redirects to video_path(video) w/ invalid input" do
        post :create, video_id: video.id, review: {}
        expect(response).to redirect_to video_path(video)
      end
    end

    context "user not signed in" do
      it "redirects to root_path" do
        video = Fabricate(:video)
        post :create, video_id: video.id, review: {}
        expect(response).to redirect_to root_path
      end
    end
  end
end
