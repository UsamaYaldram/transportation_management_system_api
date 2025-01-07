# frozen_string_literal: true

namespace :sidekiq do
  desc "Enqueue FetchTrucksWorker to fetch trucks"
  task fetch_trucks: :environment do
    FetchTrucksWorker.perform_async
    puts "FetchTrucksWorker enqueued"
  end
end
