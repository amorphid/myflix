require "spec_helper"

describe QueueItemsUpdate do
  subject { QueueItemsUpdate.new }

  describe "#error?" do
    it "returns true with an error" do
      expect(subject.error?("boom!")).to eq (true)
    end

    it "returns nil if no error" do
      expect(subject.error?(nil)).to eq (nil)
    end
  end

  describe "#normalize_priorities!" do
    it "return ar array of hashes w/ priority = to index + 1" do
      priorities = [ { priority: "11" }, { priority: "22" } ]
      expect(subject.normalize_priorities!(priorities))
        .to eq([ { priority: 1 }, { priority: 2 } ])
    end
  end

  describe "#sanitize_user_input" do
    it "returns nil for valid user input" do
      priorities = [ { priority: "-1"  },
                     { priority: "0"   },
                     { priority: "1"   },
                     { priority: "2.2" },
                     { priority: "-2.2" } ]
      expect(subject.sanitize_user_input(priorities)).to eq(nil)
    end

    it "returns error message for invalid input" do
      priorities = [ { priority: "bob" },
                     { priority: "2+2" },
                     { priority: "!@$" } ]
      expect(subject.sanitize_user_input(priorities))
        .to eq("For video priorities, integers and floats only please.")
    end
  end

  describe "#sort_by_priority!" do
    it "returns an array sorted by priority" do
      priority1  = { priority: "1" }
      priority2  = { priority: "2" }
      priorities = [ priority2, priority1]
      expect(subject.sort_by_priority!(priorities))
        .to eq([priority1, priority2])
    end

    it "raises an error with invalid input" do
      expect {subject.sort_by_priority!("me blow up")}.to raise_error
    end
  end

  describe "#update_queued_videos" do
    it "updates all queued videos with valid inputs" do
      item1 = Fabricate(:queued_video, priority: 1)
      item2 = Fabricate(:queued_video, priority: 2)
      queued_videos_data = [ { id: item1.id, priority: "2" },
                             { id: item2.id, priority: "1" } ]
      subject.update_queued_videos(queued_videos_data)
      expect(QueuedVideo.find(item1.id).priority).to eq(2)
      expect(QueuedVideo.find(item2.id).priority).to eq(1)
    end

    it "does not update any queued vides when inputs invalid" do
      item1 = Fabricate(:queued_video, priority: 1)
      item2 = Fabricate(:queued_video, priority: 2)
      queued_videos_data = [ { id: item1.id, priority: "2" },
                             { id: item2.id, priority: "bob" } ]
      expect{subject.update_queued_videos(queued_videos_data)}.to raise_error
      expect(QueuedVideo.find(item1.id).priority).to eq(1)
      expect(QueuedVideo.find(item2.id).priority).to eq(2)
    end
  end

  # describe "#update_reviews" do
  #   it "updates videos with valid inputs" do
  #     item1 = Fabricate(:review, priority: 1)
  #     item2 = Fabricate(:review, priority: 2)
  #     queued_videos_data = [ { id: item1.id, priority: "2" },
  #                            { id: item2.id, priority: "1" } ]
  #     subject.update_queued_videos(queued_videos_data)
  #     expect(QueuedVideo.find(item1.id).priority).to eq(2)
  #     expect(QueuedVideo.find(item2.id).priority).to eq(1)
  #   end

  #   it "does not update any queued vides when inputs invalid" do
  #     item1 = Fabricate(:review, priority: 1)
  #     queued_videos_data = [ { id: item1.id, priority: "2" },
  #                            { id: item2.id, priority: "bob" } ]
  #     expect{subject.update_queued_videos(queued_videos_data)}.to raise_error
  #     expect(QueuedVideo.find(item1.id).priority).to eq(1)
  #     expect(QueuedVideo.find(item2.id).priority).to eq(2)
  #   end
  # end
end

