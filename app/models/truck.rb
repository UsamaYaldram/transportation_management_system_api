# frozen_string_literal: true

class Truck < ApplicationRecord
  has_many :driver_truck_assignments
  has_many :drivers, through: :driver_truck_assignments

  validates :name, :truck_type, presence: true
end
