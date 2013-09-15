require "spec_helper"

describe Category do
  it { should have_many(:videos) }
  it { should have_many(:video_categories) }

  it { should validate_presence_of(:title) }

  context "#recent_videos" do
    let(:category) { category = Fabricate(:category) }

    before do
      category.videos << Fabricate(:video, title: "older")
      recent_videos = category.videos << Fabricate.times(6, :video, title: "newer")
    end

    it "returns the 6 most recent videos" do
      expect(category.recent_videos)
        .to match_array(Video.order("created_at DESC").limit(6))
    end

    it "sorts videos by created_at in descending order" do
      expect(category.recent_videos)
        .to eq(category.recent_videos.sort_by { |i| i.created_at }.reverse)
    end

    it "should not return the first video" do
      expect(category.recent_videos).not_to include(Video.first)
    end
  end
end
