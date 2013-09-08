require "spec_helper"

describe Category do
  it { should have_many(:videos) }
  it { should have_many(:video_categories) }

  it { should validate_presence_of(:title) }

  context "#recent_videos" do
    let(:category) { Category.first }
    let(:recent_videos)   { category.recent_videos }

    before(:each) do
      create_category_with_n_videos(7)
    end

    it "should return up 6 to most recent videos (using created_at)" do
      expect(recent_videos.count).to eq(6)
      expect(recent_videos[0]).to eq(Video.last)
      expect(recent_videos[1]).to eq(Video.find(6))
      expect(recent_videos[5]).to eq(Video.find(2))
    end

    it "should not return the first video" do
      expect(recent_videos).not_to include(Video.first)
    end
  end
end
