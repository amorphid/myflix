require "spec_helper"

describe QueuedVideo do
  it { should belong_to(:user) }
  it { should belong_to(:video) }

  it { should validate_presence_of(:priority) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:video_id) }

  it { should validate_uniqueness_of(:user_id).scoped_to(:video_id) }
end
