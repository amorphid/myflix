require "spec_helper"

feature "Updating order of items in queue" do
  let(:queued_video_1) { Fabricate(:queued_video, priority: 1) }
  let(:queued_video_2) { Fabricate(:queued_video, priority: 2) }

  background do
    sign_in
    queued_video_1
    queued_video_2
    visit my_queue_path
  end

  scenario "using positive integer" do
    within("#queue_item_1") { fill_in :priority, with: "3" }
    click_button("Update Queue")
    within("#queue_item_1") { expect(page).to have_content(queued_video_2.video.title) }
    within("#queue_item_2") { expect(page).to have_content(queued_video_1.video.title) }
  end

  scenario "using negative integer" do
    within("#queue_item_2") { fill_in :priority, with: "-3" }
    click_button("Update Queue")
    within("#queue_item_1") { expect(page).to have_content(queued_video_2.video.title) }
    within("#queue_item_2") { expect(page).to have_content(queued_video_1.video.title) }
  end

  scenario "using positive float" do
    within("#queue_item_1") { fill_in :priority, with: "2.2" }
    click_button("Update Queue")
    within("#queue_item_1") { expect(page).to have_content(queued_video_2.video.title) }
    within("#queue_item_2") { expect(page).to have_content(queued_video_1.video.title) }
  end

  scenario "using negative float" do
    within("#queue_item_2") { fill_in :priority, with: "-2.2" }
    click_button("Update Queue")
    within("#queue_item_1") { expect(page).to have_content(queued_video_2.video.title) }
    within("#queue_item_2") { expect(page).to have_content(queued_video_1.video.title) }
  end
end
