  require "spec_helper"

      describe User do
        before(:each) do
          User.create(full_name: "Bob", email: "bob@bob.com", password: "bob", password_confirmation: "bob")
        end

        it { should validate_presence_of(:email) }
        it { should validate_presence_of(:full_name) }
        it { should validate_presence_of(:password_digest) }

        it { should validate_uniqueness_of(:email) }
      end
