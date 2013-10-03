require "spec_helper"

describe Follower do
  it { should have_many(:user_followers) }
  it { should have_many(:users).through(:user_followers) }

  it { should validate_presence_of(:user_id) }
end
