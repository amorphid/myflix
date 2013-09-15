require "spec_helper"

describe Video do
  it { should have_many(:categories) }
  it { should have_many(:queued_videos) }
  it { should have_many(:video_categories) }
  it { should have_many(:reviews) }

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
    subject(:video) { Fabricate(:video) }

    it "should return an average of 0.0" do
      empty_ratings = []
      expect(video.average_rating(empty_ratings)).to eq(0.0)
    end

    it "should return an average of 3.0" do
      all_ratings = [1, 3, 5]
      expect(video.average_rating(all_ratings)).to eq(3.0)
    end

    it "should return an average of 2.7" do
      all_ratings = [1, 3, 4]
      expect(video.average_rating(all_ratings)).to eq(2.7)
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

  context "#review_ratings_as_array" do
    it "should return an empty array" do
      video = Fabricate(:video)
      expect(video.review_ratings_as_array).to eq([])
    end

    it "should return an array containing 1, 3, and 5" do
      user  = Fabricate(:user)
      video = Fabricate(:video)
      video.reviews << Fabricate(:review, rating: 1, user_id: user.id, video_id: video.id)
      video.reviews << Fabricate(:review, rating: 3, user_id: user.id, video_id: video.id)
      video.reviews << Fabricate(:review, rating: 5, user_id: user.id, video_id: video.id)
      expect(video.review_ratings_as_array).to match_array([1, 3, 5])
    end
  end

  context "#self.search_by_title" do
    let(:all_videos) { Video.all.sort }

    before(:each) do
      create_n_videos(2)
    end

    it "should find all matching videos" do
      search_results = video_search("Cool")
      expect(search_results).to eq(all_videos)
    end

    it "returns an empty array if there is no match" do
      search_results = video_search("Not Cool")
      expect(search_results).to eq([])
    end

    it "returns an empty array if search string is empty" do
      search_results = video_search("")
      expect(search_results).to eq([])
    end
  end

  def video_search(title)
    results = Video.search_by_title(title)
    results.sort
  end
end
