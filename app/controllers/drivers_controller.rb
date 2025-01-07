# frozen_string_literal: true

class DriversController < ApplicationController
  before_action :authenticate_driver, except: [:create, :login]

  # POST /drivers
  def create
    driver = Driver.new(driver_params)
    if driver.save
      render json: {
        meta: { token: JwtService.encode(driver_id: driver.id) },
        data: DriverSerializer.new(driver).serializable_hash[:data] # Remove the extra wrapping
      }, status: :created
    else
      render json: format_errors(driver.errors), status: :unprocessable_entity
    end
  end

  # POST /drivers/login
  def login
    driver = Driver.find_by(email: params[:email])
    if driver&.authenticate(params[:password])
      render json: { 
        meta: { token: JwtService.encode(driver_id: driver.id) },
        data: DriverSerializer.new(driver).serializable_hash
      }
    else
      render json: format_errors(['Invalid email or password']), status: :unauthorized
    end
  end

  private

  def driver_params
    params.require(:driver).permit(:email, :password)
  end

  def format_errors(errors)
    { errors: errors.map { |error| { detail: error } } }
  end
end