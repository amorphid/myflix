require "spec_helper"

describe ApplicationHelper do
  include ApplicationHelper

  describe "#increment_tabindex_by_one" do
    it "returns 1 when called the first time" do
      expect(increment_tabindex_by_one).to eq(1)
    end

    it "returns increase by one when called" do
      expect(increment_tabindex_by_one).to eq(1)
      expect(increment_tabindex_by_one).to eq(2)
      expect(increment_tabindex_by_one).to eq(3)
    end
  end
end
