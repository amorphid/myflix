require "spec_helper"

describe SessionsController do
  describe "requests for authenticated user" do
    before { session[:user_id] = Fabricate(:user).id }

    context "GET new" do
      it "should redirect to home_path" do
        get :new
        expect(response).to redirect_to home_path
      end
    end

    context "GET destroy" do
      it "should redirect to root_path" do
        get :destroy
        expect(response).to redirect_to root_path
      end
    end

    context "DELETE destroy" do
      it "should redirect to root_path" do
        delete :destroy
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "POST create" do
    it "should redirect to home_path with valid input" do
      user_attr = Fabricate.attributes_for(:user)
      user = Fabricate(:user, user_attr)
      post :create, email: user_attr[:email], password: user_attr[:password]
      expect(response).to redirect_to home_path
    end

    it "should redirect to sign_in_path with valid email & invalid password" do
      user_attr = Fabricate.attributes_for(:user)
      user = Fabricate(:user, user_attr)
      post :create, email: user_attr[:email], password: ""
      expect(response).to redirect_to sign_in_path
    end

    it "should render new template with no input" do
      post :create, email: "", password: ""
      expect(response).to redirect_to sign_in_path
    end
  end
end
