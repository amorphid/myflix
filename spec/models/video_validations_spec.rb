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

  it "should save with all required fields" do
    expect(video.save).to eq(true)
  end

  it "should NOT without title" do
    video.title = ""
    expect(video.save).to eq(true)
  end

  it "should NOT without description" do
    video.description = ""
    expect(video.save).to eq(true)
  end

  it "should NOT without short_cover_url" do
  video.small_cover_url = ""
    expect(video.save).to eq(true)
  end

  it "should NOT without large_cover_url" do
    video.large_cover_url = ""
    expect(video.save).to eq(true)
  end
end
