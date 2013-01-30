# encoding: UTF-8
require 'dotenv/tasks'
task :cron => :environment do
  #今日は第何週か
  time = Time.now
  number_week = (time.mday/7) + 1
  #今日は何曜日か
  today_wday = time.wday
  gomi_wday = today_wday + 1

  user_array = Tweet.includes(:user).where(cron_week: number_week).map(&:user).uniq
  user_array.each do |user|
    touban_name = "@#{user.members.find_by_turn(1).name} さん、"
    tasks = user.tweets.where(cron_week: number_week)
    tasks.each do |task|
      daily_task = task.find_by_cron_number_week(0)
      monthly_task = task.find_by_cron_number_week(number_week)
      twitter = Twitter::Client.new(oauth_token: user.access_token, oauth_token_secret: user.access_secret)
      twitter.update( truncate( touban_name + daily_task.message, length: 140 )) if daily_task
      twitter.update( truncate( touban_name + monthly_task.message, length: 140 )) if monthly_task
    end
  end

end