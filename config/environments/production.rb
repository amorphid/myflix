Myflix::Application.configure do
  config.action_controller.perform_caching = true
  config.active_support.deprecation = :notify
  config.assets.compile = false
  config.assets.digest = true
  config.assets.js_compressor = :uglifier
  config.assets.version = '1.0'
  config.cache_classes = true
  config.consider_all_requests_local       = false
  config.eager_load = true
  config.i18n.fallbacks = true
  config.log_formatter = ::Logger::Formatter.new
  config.log_level = :info

  # Set to "true" to prevent need to run "rake assets:precompile"
  # When performance starts to matter, set back to false and precompile assets
  config.serve_static_assets = true
end
