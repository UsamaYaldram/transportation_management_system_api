# frozen_string_literal: true

class TruckSerializer
  include JSONAPI::Serializer

  set_type :truck
  attributes :name, :truck_type

  # has_many :drivers    // comment this to hide relationship in response data

  attribute :driver_assignments do |truck|
    truck.drivers.map do |driver|
      {
        driver_id: driver.id,
        assign_date: truck.driver_truck_assignments.find_by(driver_id: driver.id)&.created_at&.strftime('%Y-%m-%d')
      }
    end
  end
end
