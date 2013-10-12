require "spec_helper"

describe UsersController do
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST password_reset" do
    let(:user)  { Fabricate(:user) }
    let(:token) { user.password_reset_token }

    context "with valid password and password_confirmation" do
      it "gives user a new password_reset_token" do
        post :password_reset, password_reset_token: token, password: "la", password_confirmation: "la"
        expect(User.last.password_reset_token).not_to eq(token)
      end

      it "redirects to sign in page" do
        post :password_reset, password_reset_token: token, password: "la", password_confirmation: "la"
        expect(response).to redirect_to sign_in_path
      end
    end

    context "with invalid password and/or password_confirmation" do
      it "does not change the user's password_reset_token" do
        post :password_reset, password_reset_token: token, password: "", password_confirmation: ""
        expect(User.last.password_reset_token).to eq(token)
      end

      it "redirects to the password reset page if password blank" do
        post :password_reset, password_reset_token: token, password: "", password_confirmation: "la"
        expect(response).to redirect_to reset_password_url(password_reset_token: token)
      end

      it "redirects to the password reset page if password_confirmation blank" do
        post :password_reset, password_reset_token: token, password: "la", password_confirmation: ""
        expect(response).to redirect_to reset_password_url(password_reset_token: token)
      end

      it "redirects to the password reset page if password doesn't match password confirmation" do
        post :password_reset, password_reset_token: token, password: "la", password_confirmation: ""
        expect(response).to redirect_to reset_password_url(password_reset_token: token)
      end
    end
  end

  describe "GET show" do
    it "sets @user" do
      set_current_user
      user = User.last
      get :show, id: user.id
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "POST create" do
    it "sets @User" do
      post :create, user: {}
      expect(assigns(:user)).to be_instance_of(User)
    end

    it "creates the user with valid input" do
      user_attr = Fabricate.attributes_for(:user)
      post :create, user: user_attr
      expect(User.last.email).to eq(user_attr[:email])
    end

    it "generates a password_reset_token" do
      user_attr = Fabricate.attributes_for(:user)
      post :create, user: user_attr
      expect(User.last.password_reset_token.length).to eq(22)
    end

    it "sends an email to a newly created user" do
      user_attr = Fabricate.attributes_for(:user)
      post :create, user: user_attr
      expect(ActionMailer::Base.deliveries).not_to be_empty
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
