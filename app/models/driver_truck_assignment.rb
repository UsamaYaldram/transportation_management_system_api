# frozen_string_literal: true

class DriverTruckAssignment < ApplicationRecord
  belongs_to :driver
  belongs_to :truck

  validates :driver_id, uniqueness: { scope: :truck_id, message: 'has already been assigned to this truck' }
end
