require "spec_helper"

describe SessionsController do
  let(:user) { Fabricate(:user) }

  describe "requests for authenticated user" do
    before { session[:user_id] = user.id }

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
