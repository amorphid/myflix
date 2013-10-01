require "spec_helper"

describe SessionsController do

  describe "GET new" do
    it "should redirect to home_path if user signed in" do
      set_current_user
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe "GET destroy" do
    it "should redirect to root_path if user signed in" do
      set_current_user
      get :destroy
      expect(response).to redirect_to root_path
    end
  end

  describe "DELETE destroy" do
    it "should redirect to root_path if user signed in" do
      set_current_user
      delete :destroy
      expect(response).to redirect_to root_path
    end
  end

  describe "POST create" do
    let(:user) { Fabricate(:user) }

    it "should redirect to home_path with valid input" do
      post :create, email: user.email, password: user.password
      expect(response).to redirect_to home_path
    end

    it "should redirect to sign_in_path with valid email & invalid password" do
      post :create, email: user.email, password: ""
      expect(response).to redirect_to sign_in_path
    end

    it "should render new template with invalid input" do
      post :create, email: "", password: ""
      expect(response).to redirect_to sign_in_path
    end
  end
end
