require "spec_helper"

describe AppMailer do
  describe "#send_welcome_on_sign_up" do
    let(:user) { Fabricate(:user) }
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
