# frozen_string_literal: true

class Driver < ApplicationRecord
  has_secure_password

  has_many :driver_truck_assignments
  has_many :trucks, through: :driver_truck_assignments

  validates :email, presence: true, uniqueness: true
end
