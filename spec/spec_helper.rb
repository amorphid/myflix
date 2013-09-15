ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require "capybara/rspec"

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |c|
  c.fixture_path = "#{::Rails.root}/spec/fixtures"
  c.use_transactional_fixtures = true
  c.infer_base_class_for_anonymous_controllers = false
  c.order = "random"
end
