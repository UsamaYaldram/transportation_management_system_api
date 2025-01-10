# frozen_string_literal: true

class TrucksController < ApplicationController
  before_action :authenticate_driver

  # GET /trucks
  def index
    trucks = Truck.includes(:drivers)
    render json: serialize_trucks(trucks)
  end

  # POST /trucks/assign
  def assign
    truck = Truck.find_by(id: params[:truck_id])
    if truck
      current_driver.trucks << truck
      render json: success_meta('Truck assigned successfully'), status: :ok
    else
      render json: error_meta('Truck not found'), status: :not_found
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: error_meta(e.message), status: :unprocessable_entity
  end

  # GET /trucks/assigned
  def assigned
    trucks = current_driver.trucks.includes(:drivers)
    render json: serialize_trucks(trucks)
  end

  private

  def serialize_trucks(trucks)
    TruckSerializer.new(trucks, { is_collection: true }).serializable_hash
  end

  def success_meta(message)
    { meta: { message: message } }
  end

  def error_meta(message)
    { meta: { error: message } }
  end
end