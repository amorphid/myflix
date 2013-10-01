require "spec_helper"

feature "user sign in" do
  given(:error) { "Invalid username and/or password" }
  given(:user ) { Fabricate(:user, email:                 "a@b.c",
                                   password:              "la",
                                   password_confirmation: "la") }

  background { visit sign_in_path }

  scenario "succeeds with valid email and password" do
    fill_in      "Email",    with: user.email
    fill_in      "Password", with: user.password
    click_button "Sign in"
    expect(page).to have_content("You have successfully logged in")
  end

  scenario "fails with invalid email" do
    fill_in      "Email",    with: "hillary@clinton.org"
    fill_in      "Password", with: user.password
    click_button "Sign in"
    expect(page).to have_content(error)
  end

  scenario "fails with invalid password" do
    fill_in      "Email",    with: user.email
    fill_in      "Password", with: "not la"
    click_button "Sign in"
    expect(page).to have_content(error)
  end

  scenario "fails with blank email" do
    fill_in      "Email",    with: ""
    fill_in      "Password", with: user.password
    click_button "Sign in"
    expect(page).to have_content(error)
  end

  scenario "fails with blank password" do
    fill_in      "Email",    with: user.email
    fill_in      "Password", with: ""
    click_button "Sign in"
    expect(page).to have_content(error)
  end

  scenario "fails with blank email and blank password" do
    fill_in      "Email",    with: ""
    fill_in      "Password", with: ""
    click_button "Sign in"
    expect(page).to have_content(error)
  end
end
