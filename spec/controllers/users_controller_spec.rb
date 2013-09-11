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
      user = Fabricate.build(:user)
      post :create, user: { full_name:            user.full_name,
                            email:                 user.email,
                            password:              user.password,
                            password_confirmation: user.password_confirmation }

      expect(User.last.email).to eq(user.email)
    end

    it "redirects to sign_in_path with valid input" do
      user = Fabricate.build(:user)
      post :create, user: { full_name:             user.full_name,
                            email:                 user.email,
                            password:              user.password,
                            password_confirmation: user.password_confirmation }

      expect(response).to redirect_to sign_in_path
    end

    it "does not create user with duplicate email address" do
      existing_user = Fabricate(:user)
      new_user      = Fabricate.build(:user)
      post :create, user: { full_name:             new_user.full_name,
                            email:                 existing_user.email,
                            password:              new_user.password,
                            password_confirmation: new_user.password_confirmation }

      expect(response).to render_template :new
    end

    it "does not create user with invalit input (such as missing email)" do
      new_user      = Fabricate.build(:user)
      post :create, user: { full_name:             new_user.full_name,
                            password:              new_user.password,
                            password_confirmation: new_user.password_confirmation }

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

