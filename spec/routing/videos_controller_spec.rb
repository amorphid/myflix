require "spec_helper"

describe VideosController do
  it { should route(:get, "/videos/search").to(:action => "search") }
end

