require "spec_helper"

describe Video do
  it { should have_many(:categories) }
  it { should have_many(:comments) }
  it { should have_many(:video_categories) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:small_cover_url) }
  it { should validate_presence_of(:large_cover_url) }

  context "#search_by_title" do
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
