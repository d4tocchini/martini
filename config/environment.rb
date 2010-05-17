# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Martini::Application.initialize!

=begin
ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address => "smtp.gmail.com",
  :port => 587,
  :domain => "your-google-apps-domain",
  :authentication => :plain,
  :user_name => "username",
  :password => "password"
}
=end