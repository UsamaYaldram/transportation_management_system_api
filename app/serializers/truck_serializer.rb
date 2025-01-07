# frozen_string_literal: true

class TruckSerializer
  include JSONAPI::Serializer

  set_type :truck
  attributes :name, :truck_type

  has_many :drivers
end
