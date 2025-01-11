# frozen_string_literal: true

set :output, "log/cron.log" # Logs the cron job output to a file

set :environment, ENV['RAILS_ENV'] || 'development'

env :PATH, ENV['PATH']

every 1.day, at: '12:00 am' do
  rake "sidekiq:fetch_trucks"
end
