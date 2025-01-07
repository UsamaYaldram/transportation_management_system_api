# frozen_string_literal: true

set :output, "log/cron.log" # Logs the cron job output to a file

every 1.day, at: '12:00 am' do
  rake "sidekiq:fetch_trucks"
end
