# encoding: UTF-8
require 'dotenv/tasks'
task :cron => :environment do
  user = User.first
  twitter = Twitter::Client.new(oauth_token: user.access_token, oauth_token_secret: user.access_secret)
  twitter.update(Time.now)
end