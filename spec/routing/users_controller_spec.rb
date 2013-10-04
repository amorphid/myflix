require "spec_helper"

describe UsersController do
  it { should route(:get, "/people").to(:action => "index") }
end
