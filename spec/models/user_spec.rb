require "spec_helper"

describe User do
  it { should have_many(:queued_videos) }
  it { should have_many(:reviews) }
  it { should have_many(:videos).through(:queued_videos) }

  it "should have many queued videos sorted by priority" do
    queued_videos = Fabricate.times(4, :queued_video)
    expect(User.last.prioritized_queued_videos).to eq(queued_videos.sort_by(&:priority))
  end

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:full_name) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:password_confirmation) }
  it { should validate_presence_of(:password_reset_token) }

  it do
    Fabricate(:user)
    should validate_uniqueness_of(:email)
  end
end
