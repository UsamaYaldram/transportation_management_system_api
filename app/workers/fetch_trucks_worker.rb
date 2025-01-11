# frozen_string_literal: true

class FetchTrucksWorker
  include Sidekiq::Worker
  include HTTParty

  sidekiq_options retry: 3, queue: "default"

  BASE_URL = Rails.application.credentials.dig(:api, :trucks, :base_url)
  API_KEY = Rails.application.credentials.dig(:api, :trucks, :api_key)

  def perform
    page = 1

    loop do
      response = self.class.get(
        BASE_URL,
        headers: { "API_KEY" => API_KEY },
        query: { page: page }
      )

      if response.success?
        trucks = response.parsed_response
        trucks.each do |truck|
          Truck.find_or_create_by(
            id: truck["id"]
          ) do |t|
            t.name = truck["name"]
            t.truck_type = truck["truck_type"]
            t.created_at = truck["created_at"]
            t.updated_at = truck["updated_at"]
          end
        end

        # Logging the progress
        puts "Page #{page} processed successfully."

        # Check if we've reached the last page
        total_pages = response.headers["total-pages"].to_i
        break if page >= total_pages

        # Move to the next page
        page += 1
      else
        raise "Failed to fetch trucks on page #{page}: #{response.code} - #{response.message}"
      end
    end
  end
end
