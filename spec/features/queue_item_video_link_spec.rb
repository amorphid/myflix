require "spec_helper"

feature "Queue item video link" do
  let(:video1) { Video.first }
  let(:video2) { Video.last }

  background do
    sign_in
    Fabricate.times(2, :queued_video)
    visit my_queue_path
  end

  scenario "first queue item links to video1" do
    click_link(video1.title)
    expect(current_path).to     eq(video_path(video1))
    expect(page)        .to     have_content(video1.title)
    expect(page)        .not_to have_content(video2.title)
  end

  scenario "second queue item links to video2" do
    click_link(video2.title)
    expect(current_path).to     eq(video_path(video2))
    expect(page)        .to     have_content(video2.title)
    expect(page)        .not_to have_content(video1.title)
  end
end
