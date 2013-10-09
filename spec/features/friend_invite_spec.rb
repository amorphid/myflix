require "spec_helper"

feature "Inviting a friend" do
  let(:valid_email)   { "bob@example" }
  let(:invalid_email) { "I can haz cheezeburger?" }

  background do
    sign_in
    visit invite_path
  end

  scenario "succeeds with valid email" do
    fill_in "email", with: valid_email
    click_button("Send Invitation")
    expect(page).to have_content("Friend invited.  Invite another!")
  end

  scenario "succeeds with ridiculously invalid email" do
    fill_in "email", with: invalid_email
    click_button("Send Invitation")
    expect(page).to have_content("Friend invited.  Invite another!")
  end

  scenario "fails without email" do
    click_button("Send Invitation")
    expect(page).to have_content("Email may not be blank")
  end
end
