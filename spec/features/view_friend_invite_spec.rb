require "spec_helper"

feature "When reading a friend invite," do

  let(:user) { Fabricate(:user) }

  background do
    sign_in
    visit invite_path
    fill_in "full_name", with: user.full_name
    fill_in "email",     with: user.email
    click_button("Send Invitation")
    visit sign_out_path
    open_email(user.email)
    current_email.click_link("this link")
  end

  context "clicking on the link" do
    scenario "takes me to the sign up page" do
      expect(current_url).to eq(sign_up_url(
        email: user.email, full_name: user.full_name))
    end
  end

  context "the sign up page" do
    scenario "shows my email address" do
      expect(find("#user_email").value).to eq(user.email)
    end

    scenario "shows my name" do
      expect(find("#user_full_name").value).to eq(user.full_name)
    end
  end
end
