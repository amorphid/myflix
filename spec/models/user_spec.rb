  require "spec_helper"

  describe User do
    it do
      FactoryGirl.create(:user)
      should validate_uniqueness_of(:email)
    end

    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:full_name) }
    it { should validate_presence_of(:password_digest) }
  end
