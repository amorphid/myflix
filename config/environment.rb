# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Myflix::Application.initialize!

# sending email
ActionMailer::Base.default_url_options = { host: ENV["domain"] }
ActionMailer::Base.smtp_settings = {
  :user_name =>     ENV["email_username"],
  :password =>      ENV["email_password"],
  :domain =>        ENV["domain"],
  :address =>       "smtp.sendgrid.net",
  :port =>           587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
