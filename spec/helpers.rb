module Helpers
  def create_n_videos(n)
    2.times { FactoryGirl.create(:video) }
  end
end
