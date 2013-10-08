require "spec_helper"

feature "Requesting a forgotten password" do
  given(:error) { "Invalid email" }
  given(:user)  { Fabricate(:user, email: "bob@example.com") }

  before do
    visit sign_in_path
    click_link("Forgot password?")
  end

  scenario "I see a success message with a valid email" do
    fill_in "email", with: user.email
    click_button("Submit email")
    expect(page).to have_content(
      "We have sent an email with instruction to reset your password.")
  end

  scenario "I see an error message with an invalid email" do
    fill_in "email", with: ""
    click_button("Submit email")
    expect(page).to have_content(error)
  end

  scenario "I see an error message with a blank email" do
    fill_in "email", with: ""
    click_button("Submit email")
    expect(page).to have_content(error)
  end
end
