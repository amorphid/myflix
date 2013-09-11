require "spec_helper"

describe UsersController do
  context "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_a(User)
    end
  end

  context "POST create" do
    it "sets @User" do
      post :create, user: {}
      expect(assigns(:user)).to be_instance_of(User)
    end

    it "creates the user with valid input" do
      user_attr = Fabricate.attributes_for(:user)
      post :create, user: user_attr
      expect(User.last.email).to eq(user_attr[:email])
    end

    it "redirects to sign_in_path with valid input" do
      post :create, user: Fabricate.attributes_for(:user)
      expect(response).to redirect_to sign_in_path
    end

    it "will reject duplicate email address & not save user" do
      post :create, user: Fabricate.attributes_for(:user)
      expect(User.count).to eq(1)

      post :create, user: Fabricate.attributes_for(:user, email: User.last)
      expect(User.count).to eq(1)
    end

    it "renders new template with invalit input (such as missing email)" do
      post :create, user: Fabricate.attributes_for(:user, email: "")
      expect(response).to render_template :new
    end
  end
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

