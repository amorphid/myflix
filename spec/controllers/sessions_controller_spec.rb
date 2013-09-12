require "spec_helper"

describe SessionsController do
  context "GET new" do
    it "should redirect to home_path with authenticated user" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
  end

  context "GET destroy" do
    it "should redirect to root_path" do
      session[:user_id] = Fabricate(:user).id
      get :destroy
      expect(response).to redirect_to root_path
    end
  end

  context "DELETE destroy" do
    it "should redirect to root_path" do
      session[:user_id] = Fabricate(:user).id
      delete :destroy
      expect(response).to redirect_to root_path
    end
  end

  context "POST create" do
    it "should redirect to home_path with valid input" do
      user_attr = Fabricate.attributes_for(:user)
      user = Fabricate(:user, user_attr)
      post :create,
        email:    user_attr[:email],
        password: user_attr[:password]
      expect(response).to redirect_to home_path
    end

    it "should render new template with valid email & invalid password" do
      user_attr = Fabricate.attributes_for(:user)
      user = Fabricate(:user, user_attr)
      post :create,
          email:    user_attr[:email],
          password: ""
      expect(response).to redirect_to sign_in_path
    end

    it "should render new template with no input" do
      post :create,
        email:    "",
        password: ""
      expect(response).to redirect_to sign_in_path
    end
  end
end
