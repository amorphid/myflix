require "spec_helper"

feature "I unfollow a user" do
  given(:follower) { Follower.create(user_id: user.id) }
  given(:href)     { "/followers/" + follower.id.to_s + "?user_id=" + leader.id.to_s }
  given(:leader)   { Fabricate(:user) }
  given(:user)     { User.first }

  background do
    sign_in
    follower.users << leader
  end

  scenario "by clicking on the 'Unfollow' button" do
    visit user_path(leader)
    click_button("Unfollow")
    expect(page).to have_button("Follow")
  end

  scenario "by clicking on the 'X' icon" do
    visit people_path
    expect(page).to have_content(leader.full_name)
    find(:xpath, "//a[@href='#{href}']").click
    expect(current_path).to eq(people_path)
    expect(page).not_to have_content(leader.full_name)
  end
end
