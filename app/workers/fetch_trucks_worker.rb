# frozen_string_literal: true

class FetchTrucksWorker
  include Sidekiq::Worker

  def perform
    api_key = 'illa-trucks-2023'
    page = 1

    loop do
      response = RestClient.get(
        "https://api-task-bfrm.onrender.com/api/v1/trucks",
        headers: { API_KEY: api_key, params: { page: page } }
      )
      data = JSON.parse(response.body)
      data['trucks'].each do |truck|
        Truck.find_or_create_by(name: truck['name'], truck_type: truck['truck_type'])
      end
      break if page >= response.headers['total-pages'].to_i
      page += 1
    end
  end
end
