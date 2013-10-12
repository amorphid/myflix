require "spec_helper"

describe PasswordResetsController do

  describe "POST update" do
    let(:user)  { Fabricate(:user) }
    let(:token) { user.password_reset_token }

    context "with valid password and password_confirmation" do
      it "gives user a new password_reset_token" do
        post :update, password_reset_token: token, password: "la", password_confirmation: "la"
        expect(User.last.password_reset_token).not_to eq(token)
      end

      it "redirects to sign in page" do
        post :update, password_reset_token: token, password: "la", password_confirmation: "la"
        expect(response).to redirect_to sign_in_path
      end
    end

    context "with invalid password and/or password_confirmation" do
      it "does not change the user's password_reset_token" do
        post :update, password_reset_token: token, password: "", password_confirmation: ""
        expect(User.last.password_reset_token).to eq(token)
      end

      it "redirects to the password reset page if password blank" do
        post :update, password_reset_token: token, password: "", password_confirmation: "la"
        expect(response).to redirect_to reset_password_url(password_reset_token: token)
      end

      it "redirects to the password reset page if password_confirmation blank" do
        post :update, password_reset_token: token, password: "la", password_confirmation: ""
        expect(response).to redirect_to reset_password_url(password_reset_token: token)
      end

      it "redirects to the password reset page if password doesn't match password confirmation" do
        post :update, password_reset_token: token, password: "la", password_confirmation: ""
        expect(response).to redirect_to reset_password_url(password_reset_token: token)
      end
    end
  end

  describe "POST create" do
    context "with valid email" do
      let(:user) { Fabricate(:user) }

      it "redirects to confirm password reset page" do
        post :create, email: user.email
        expect(response).to redirect_to confirm_password_reset_path
      end

      it "sends email for resetting password" do
        post :create, email: user.email
        expect(ActionMailer::Base.deliveries).not_to be_empty
      end
    end

    it "redirects to sign in page w/ invalid email" do
      post :create, email: "invalid@email.address"
      expect(response).to redirect_to forgot_password_path
    end

    it "redirects to sign in page w/ blank email" do
      post :create, email: ""
      expect(response).to redirect_to forgot_password_path
    end
  end
end
