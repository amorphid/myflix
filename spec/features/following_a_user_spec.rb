require "spec_helper"

feature "Clicking on the 'Follow' button" do
  given(:user) { Fabricate(:user, full_name: "Susie Q") }

  background do
    sign_in
    visit user_path(user)
    click_button "Follow"
  end

  scenario "displayes a success message" do
    expect(page).to have_content ("You are now following "  + user.full_name)
  end

  scenario "displays an 'Unfollow' button" do
    expect(page).to have_button("Unfollow")
  end

  scenario "causes newly followed user to be displayed on page '/people'" do
    visit people_path
    expect(page).to have_content(user.full_name)
  end

  scenario "redirects to the followed user's profile" do
    expect(current_path).to eq(user_path(user))
  end
end
