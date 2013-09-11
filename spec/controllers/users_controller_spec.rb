require "spec_helper"

describe UsersController do
  context "GET new" do
  end


  # context "GET index" do
  #   it "sets @videos for authenticated users" do
  #     session[:user_id] = Fabricate(:user).id
  #     categories = Fabricate.times(2, :category) { videos(count: 2) }
  #     get :index
  #     expect(assigns(:categories)).to eq(categories.sort)
  #   end

  #   it "redirects to root_path for unauthenticaed users" do
  #     categories = Fabricate.times(2, :category) { videos(count: 2) }
  #     get :index
  #     expect(response).to redirect_to root_path
  #   end
  # end

  # context "POST search" do
  #   it "sets @videos for authenticated users" do
  #     session[:user_id] = Fabricate(:user).id
  #     title = Faker::Lorem.words(2).join(" ")
  #     videos = Fabricate.times(2, :video, title: title)
  #     post :search, title: title
  #     expect(assigns(:videos)).to eq(videos)
  #   end

  #   it "redirects to root_path for unauthenticaed users" do
  #     post :search, title: Faker::Lorem.words(2).join(" ")
  #     expect(response).to redirect_to root_path
  #   end
  # end

  # context "GET show" do
  #   it "sets @video for authenticated users" do
  #     session[:user_id] = Fabricate(:user).id
  #     video = Fabricate(:video)
  #     get :show, id: video.id
  #     expect(assigns(:video)).to eq(video)
  #   end

  #   it "redirects to root_path for unauthenticaed users" do
  #     get :show, id: rand(9999999999)
  #     expect(response).to redirect_to root_path
  #   end
  # end
end
