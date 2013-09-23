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

  describe "#review" do
    let(:queued_video) { Fabricate(:queued_video) }

    it "returns the review with matching user_id and video_id if it exists" do
      review = Fabricate(:review, user_id: queued_video.user_id, video_id: queued_video.video_id)
      expect(queued_video.review).to eq(review)
    end

    it "returns nil if no review exists" do
      expect(queued_video.review).to eq(nil)
    end
  end
end
