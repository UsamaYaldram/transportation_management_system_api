# frozen_string_literal: true

class DriverTruckAssignment < ApplicationRecord
  belongs_to :driver
  belongs_to :truck
end
