require "spec_helper"

describe VideosController do
  context "GET index" do
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

  context "POST search" do
    it "sets @videos for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      title = Faker::Lorem.words(2).join(" ")
      videos = Fabricate.times(2, :video, title: title)
      post :search, title: title
      expect(assigns(:videos)).to eq(videos)
    end

    it "redirects to root_path for unauthenticaed users" do
      post :search, title: Faker::Lorem.words(2).join(" ")
      expect(response).to redirect_to root_path
    end
  end

  context "GET show" do
    it "redirects to root_path for unauthenticaed users" do
      get :show, id: rand(9999999999)
      expect(response).to redirect_to root_path
    end

    it "sets @average_rating for authenticated Users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      Fabricate.times(2, :review, user_id: User.last.id, video_id: video.id)
      get :show, id: video.id
      expect(assigns(:average_rating)).to eq(video.average_rating(video.review_ratings_as_array))
    end

    it "sets @review for authenticated Users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:review)).to be_a(Review)
    end

    it "sets @reviews for authenticated Users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      video.reviews << Fabricate.times(2, :review, video_id: video.id, user_id: User.last.id)
      get :show, id: video.id
      expect(assigns(:reviews)).to eq(video.reviews)
    end

    it "sets @video for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end


  end
end
