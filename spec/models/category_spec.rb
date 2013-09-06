require "spec_helper"

describe Category do
  let(:category) { Category.new(title: "Banana") }

  it { should have_many(:videos) }
  it { should have_many(:video_categories) }

  it "should save w/ title" do
    expect(category.save).to be_true
  end

  it "should not save w/o title" do
    category.title = ""
    expect(category).to have(1).errors_on(:title)
  end
end
