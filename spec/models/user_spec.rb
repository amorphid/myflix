require "spec_helper"

describe User do
  it { should have_many(:queued_videos) }
  it { should have_many(:reviews) }
  it { should have_many(:videos).through(:queued_videos) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:full_name) }
  it { should validate_presence_of(:password_digest) }

  it do
    Fabricate(:user)
    should validate_uniqueness_of(:email)
  end
end
