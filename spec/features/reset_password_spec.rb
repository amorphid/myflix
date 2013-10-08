require "spec_helper"

feature "A password reset" do
  given(:user) { Fabricate(:user) }

  background do
    visit forgot_password_path
    fill_in "email", with: user.email
    click_button("Submit email")
    open_email(user.email)
    current_email.click_link("this link")
  end

  scenario "succed with matching passwords" do
    fill_in "password", with: "hehe"
    fill_in "password_confirmation", with: "hehe"
    click_button("Reset password")
    expect(page).to have_content("Password has been reset & you may login")
  end

  scenario "fails with non matching passwords" do
    fill_in "password", with: "hehe"
    fill_in "password_confirmation", with: "lala"
    click_button("Reset password")
    expect(page).to have_content("Passwords must match")
  end

  scenario "fails with blank password" do
    fill_in "password", with: ""
    fill_in "password_confirmation", with: "hehe"
    click_button("Reset password")
    expect(page).to have_content("Passwords must be 1 or more characters")
  end

  scenario "fails with blank password confirmation" do
    fill_in "password", with: "hehe"
    fill_in "password_confirmation", with: ""
    click_button("Reset password")
    expect(page).to have_content("Passwords must be 1 or more characters")
  end
end
