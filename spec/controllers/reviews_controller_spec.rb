require "spec_helper"

describe ReviewsController do
  describe "POST create" do
    let(:video)       { video = Fabricate(:video) }
    let(:review_attr) { Fabricate.attributes_for(
                        :review, user_id: "", video_id: video.id) }

    before { set_current_user }

    it "create a review w/ valid input" do
      post :create, video_id: video.id, review: review_attr
      expect(Review.count).to eq(1)
    end

    it "redirects to video_path(video) w/ valid input" do
      post :create, video_id: video.id, review: review_attr
      expect(response).to redirect_to video_path(video)
    end

    it "redirects to video_path(video) w/ invalid input" do
      post :create, video_id: video.id, review: {}
      expect(response).to redirect_to video_path(video)
    end

    it_behaves_like "require_sign_in" do
      let(:action) { post :create, video_id: video.id, review: {} }
    end
  end
end
