# frozen_string_literal: true

class TrucksController < ApplicationController
  before_action :authenticate_driver

  # GET /trucks
  def index
    trucks = Truck.all
    render json: TruckSerializer.new(trucks, { is_collection: true }).serializable_hash
  end

  # POST /trucks/assign
  def assign
    truck = Truck.find(params[:truck_id])
    current_driver.trucks << truck
    render json: { meta: { message: 'Truck assigned successfully' } }, status: :ok
  end

  # GET /trucks/assigned
  def assigned
    trucks = current_driver.trucks.includes(:drivers)
    render json: TruckSerializer.new(trucks, { is_collection: true }).serializable_hash
  end
end