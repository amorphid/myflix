require "spec_helper"

describe Video do
  let(:params) { {} }
  let(:all_videos) { Video.all.sort }

  it { should have_many(:categories) }
  it { should have_many(:video_categories) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:small_cover_url) }
  it { should validate_presence_of(:large_cover_url) }

  context "#search_by_title" do
    before(:each) do
      create_n_videos(2)
      set_params_title
    end

    it "shoild find all matching videos" do
      expect(search_results).to eq(all_videos)
    end
  end

  def create_n_videos(n)
    2.times { FactoryGirl.create(:video) }
  end

  def search_results
    results = Video.search_by_title(params)
    results.sort
  end

  def set_params_title
    video          = Video.first
    title          = video.title
    first_word     = title.split(" ")[0]
    params[:title] = first_word
  end
end
