require "spec_helper"

describe Video do
  it { should have_many(:categories).through(:video_categories) }
  it { should have_many(:queued_videos) }
  it { should have_many(:reviews) }
  it { should have_many(:video_categories) }

  # tried testing reviews via the follouwing shoulda test
  # it { should have_many(:reviews).order("created_at DESC") }
  # but it doesn's appear to work in Rails 4, so using this instead:
  it "should have many reviews sorted by created_at in descending order" do
    video = Fabricate(:video)
    Fabricate.times(2, :review, user: Fabricate(:user), video: video)
    expect(video.reviews).to eq(video.reviews.sort_by { |i| i.created_at }.reverse)
  end

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:small_cover_url) }
  it { should validate_presence_of(:large_cover_url) }

  context "#average_rating" do
    let(:user)  { Fabricate(:user)  }
    let(:video) { Fabricate(:video) }

    it "should return an average of 0.0" do
      expect(video.average_rating).to eq(0.0)
    end

    it "should return an average of 3.0" do
      Fabricate(:review, rating: 1, user_id: user.id, video_id: video.id)
      Fabricate(:review, rating: 3, user_id: user.id, video_id: video.id)
      Fabricate(:review, rating: 5, user_id: user.id, video_id: video.id)
      expect(video.average_rating).to eq(3.0)
    end

    it "should return an average of 2.7" do
      Fabricate(:review, rating: 1, user_id: user.id, video_id: video.id)
      Fabricate(:review, rating: 3, user_id: user.id, video_id: video.id)
      Fabricate(:review, rating: 4, user_id: user.id, video_id: video.id)
      expect(video.average_rating).to eq(2.7)
    end
  end

  describe "#in_queue?" do
    let(:user)  { Fabricate(:user)  }
    let(:video) { Fabricate(:video) }

    it "returns true if video in queue" do
      Fabricate(:queued_video, user_id: user.id, video_id: video.id)
      expect(video.in_queue?(user)).to eq(true)
    end

    it "returns false if video not in queue" do
      expect(video.in_queue?(user)).to eq(false)
    end
  end

  context "#self.search_by_title" do
    it "should find all matching videos" do
      video1 = Fabricate(:video, title: "star trek")
      video2 = Fabricate(:video, title: "star wars")
      video3 = Fabricate(:video, title: "gremlins")
      expect(Video.search_by_title("star")).to match_array([video1, video2])
    end

    it "returns an empty array if there is no match" do
      Fabricate(:video, title: "abc")
      expect(Video.search_by_title("123")).to eq([])
    end

    it "returns an empty array if search string is empty" do
      expect(Video.search_by_title("")).to eq([])
    end
  end
end
