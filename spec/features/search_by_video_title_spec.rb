require "spec_helper"

describe "Search by video title" do
  before(:each) do
    create_n_videos(2)
    user = FactoryGirl.create(:user)
    visit sign_in_path
    fill_in "email", with: "mike@mike.mike"
    fill_in "password", with: "la"
    click_button "Sign in"
  end

  it "should find 2 videos" do
    within("#header-search-bar") do
      fill_in "title", with: "cool"
    end

    click_button "search"
    expect(page.body).to have_content(Video.first.title)
    expect(page.body).to have_content(Video.last.title)
  end

  it "it should return no videos w/ empty search box" do
    within("#header-search-bar") do
      fill_in "title", with: ""
    end

    click_button "search"
    expect(page.body).to have_content("Please enter 1 or more characters.  Previous search contained 0 characters.")
  end

  it "should say there are no results for that search" do
    within("#header-search-bar") do
      fill_in "title", with: "not cool"
    end

    click_button "search"
    expect(page.body).to have_content("No results for search \"not cool\"")
  end
end
