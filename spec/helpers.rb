module Helpers
  def create_n_videos(n)
    n.times { FactoryGirl.create(:video) }
  end

  def create_category_with_n_videos(n)
    create_n_videos(7)
    FactoryGirl.create(:category_with_videos)
  end
end
