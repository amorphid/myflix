require "spec_helper"

feature "Updating order of items in queue" do
  before do
    sign_in
    Fabricate.times(2, :queued_video)
    visit my_queue_path
  end

  scenario "using positive integer" do
    fill_in :video_1_priority, with: "3"
    click_button("Update Queue")
    expect(find("#video_2_priority").value).to eq("1")
    expect(find("#video_1_priority").value).to eq("2")
  end

  scenario "using negative integer" do
    fill_in :video_2_priority, with: "-1"
    click_button("Update Queue")
    expect(find("#video_2_priority").value).to eq("1")
    expect(find("#video_1_priority").value).to eq("2")
  end

  scenario "using positive float" do
    fill_in :video_1_priority, with: "2.2"
    click_button("Update Queue")
    expect(find("#video_2_priority").value).to eq("1")
    expect(find("#video_1_priority").value).to eq("2")
  end

  scenario "using negative float" do
    fill_in :video_2_priority, with: "-1.1"
    click_button("Update Queue")
    expect(find("#video_2_priority").value).to eq("1")
    expect(find("#video_1_priority").value).to eq("2")
  end
end
