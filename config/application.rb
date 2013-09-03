require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module Myflix
  class Application < Rails::Application
    config.generators do |g|
      g.orm :active_record
      g.template_engine :haml
    end
  end
end
