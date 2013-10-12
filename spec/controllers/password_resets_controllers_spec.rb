require "spec_helper"

describe PasswordResetsController do
  describe "POST request_reset_password" do
    context "with valid email" do
      let(:user) { Fabricate(:user) }

      it "redirects to confirm password reset page" do
        post :request_password_reset, email: user.email
        expect(response).to redirect_to confirm_password_reset_path
      end

      it "sends email for resetting password" do
        post :request_password_reset, email: user.email
        expect(ActionMailer::Base.deliveries).not_to be_empty
      end
    end

    it "redirects to sign in page w/ invalid email" do
      post :request_password_reset, email: "invalid@email.address"
      expect(response).to redirect_to forgot_password_path
    end

    it "redirects to sign in page w/ blank email" do
      post :request_password_reset, email: ""
      expect(response).to redirect_to forgot_password_path
    end
  end
end
