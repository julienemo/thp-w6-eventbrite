# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => ENV['SENDGRID_LOGIN'],
  :password => ENV['SENDGRID_PWD'],
  :domain => 'gmail.com',
  :address => 'smtp.sendgrid.net',
  :enable_starttls_auto => true

#  :address            => 'smtp.gmail.com',
#  :port               => 587,
#  :domain             => 'gmail.com', #you can also use google.com
#  :authentication     => :plain,
#  :user_name          => ENV['GMAIL_LOGIN'],
#  :password           => ENV['GMAIL_PWD']
}
