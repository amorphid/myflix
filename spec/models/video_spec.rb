require "spec_helper"

describe Video do
  let(:video) do
    Video.new(
      title: "A title",
      description: "A description",
      small_cover_url: "/foo/bar-small.jpg",
      large_cover_url: "/foo/bar-large.jpg"
    )
  end

  it { should have_many(:categories) }
  it { should have_many(:video_categories) }

  it "should save w/ title, description, small_cover_url, & large_cover_url" do
    expect(video).to be_valid
  end

  it "should not save w/o title" do
    video.title = ""
    expect(video).to have(1).errors_on(:title)
  end

  it "should not save w/o description" do
    video.description = ""
    expect(video).to have(1).errors_on(:description)
  end

  it "should not save w/o small_cover_url" do
    video.small_cover_url = ""
    expect(video).to have(1).errors_on(:small_cover_url)
  end

  it "should not save w/o large_cover_url" do
    video.large_cover_url = ""
    expect(video).to have(1).errors_on(:large_cover_url)
  end
end
