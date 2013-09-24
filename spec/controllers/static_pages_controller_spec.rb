require "spec_helper"

describe StaticPagesController do
  describe "GET front" do
    it "redirects to home page if signed in" do
      session[:user_id] = Fabricate(:user).id
      get :front
      expect(response).to redirect_to home_path
    end

    it "does not redirect to home page if not signed in" do
      visit root_path
      expect(current_path).to eq(root_path)
    end
  end
end
