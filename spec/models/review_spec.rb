require "spec_helper"

describe Review do
  it { should belong_to(:user) }
  it { should belong_to(:video) }

  it { should validate_presence_of(:rating) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:video_id) }

  context "validating presence of description" do
    it "saves when description 1 or more characters" do
      Fabricate(:review, description: "a")
      expect(Review.count).to eq(1)
    end

    it "saves when description is nil" do
      Fabricate(:review, description: nil)
      expect(Review.count).to eq(1)
    end

    it "does not save when description is an empty string" do
      review = Fabricate.attributes_for(:review, description: "")
      expect {review.save}.to raise_error
    end
  end
end
