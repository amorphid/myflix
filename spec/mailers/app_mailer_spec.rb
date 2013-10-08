require "spec_helper"

describe AppMailer do
  let(:user) { Fabricate(:user) }

  describe "#password_reset" do
    subject { ActionMailer::Base.deliveries.last }
    before { AppMailer.password_reset(user).deliver }

    it "addesses email to correct user" do
      expect(subject.to).to eq([user.email])
    end

    it "generates the correct subject" do
      expect(subject.subject).to eq("[MyFlix] Password reset")
    end

    it "includes the correct password reset url" do
      href = reset_password_url(password_reset_token: user.password_reset_token)
      expect(subject.body).to include(href)
    end
  end

  describe "#send_welcome_on_sign_up" do
    subject    { ActionMailer::Base.deliveries.last }
    before     { AppMailer.send_welcome_on_sign_up(user).deliver }

    it "addesses email to correct user" do
      expect(subject.to).to eq([user.email])
    end

    it "contains the user's name" do
      expect(subject.body).to have_content(user.full_name)
    end
  end
end
