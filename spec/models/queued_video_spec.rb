require "spec_helper"

describe QueuedVideo do
  it { should belong_to(:user) }
  it { should belong_to(:video) }

  it { should validate_presence_of(:priority) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:video_id) }

  it "should validate uniqueness of user_id and video_id" do
    QueuedVideo.create(priority: 1, user_id: 1, video_id: 1)
    queued_video = QueuedVideo.new(priority: 1, user_id: 1, video_id: 1)
    expect(queued_video.save).to eq(false)
  end

  describe "#is_positive_integer?" do
    let(:queued_video) { Fabricate(:queued_video) }

    it "returns true if positive integer" do
      queued_video.priority = 3
      expect(queued_video.priority_is_positive_integer?).to eq(true)
    end

    it "returns false if not an integer" do
      queued_video.priority = "banana"
      expect(queued_video.priority_is_positive_integer?).to eq(false)
    end

    it "returns false if 0" do
      queued_video.priority = 0
      expect(queued_video.priority_is_positive_integer?).to eq(false)
    end

    it "returns false if negative number" do
      queued_video.priority = -7
      expect(queued_video.priority_is_positive_integer?).to eq(false)
    end
  end
end
