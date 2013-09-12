require "spec_helper"

describe VideosController do
  it { should route(:post, "/videos/search").to(:action => "search") }
end

