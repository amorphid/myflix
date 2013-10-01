require "spec_helper"

feature "queue item addition and removal" do
  given(:href)         { "/videos/" + video.id.to_s + "/queued_videos/" + queued_video.id.to_s }
  given(:video)        { Fabricate(:video) }
  given(:user )        { User.last  }
  given(:queued_video) { Fabricate(:queued_video, user_id: user.id, video_id: video.id) }
  given(:removal_note) { video.title + " successfully removed from your queue" }

  background { sign_in }

  scenario "adds items upon clicking '+ My Queue' link" do
    visit video_path(video)
    click_link("+ My Queue")
    expect(page).to have_content(video.title + " successfully added to your queue")
  end

  scenario "removes items upon clicking '- My Queue' link" do
    queued_video
    visit video_path(video)
    click_link("- My Queue")
    expect(page).to have_content(removal_note)
  end

  scenario "removes items upon clicking 'X' button" do
    queued_video
    visit my_queue_path
    find(:xpath, "//a[@href='#{href}']").click
    expect(page).to have_content(removal_note)
  end
end
