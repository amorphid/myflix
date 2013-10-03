require "spec_helper"

describe UserFollower do
  it { should belong_to(:follower) }
  it { should belong_to(:user) }
end
