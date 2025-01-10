# frozen_string_literal: true

class DriversController < ApplicationController
  before_action :authenticate_driver, except: [:create, :login]

  # POST /drivers
  def create
    driver = Driver.new(driver_params)
    if driver.save
      render json: success_response(driver), status: :created
    else
      render json: format_errors(driver.errors.full_messages), status: :unprocessable_entity
    end
  end

  # POST /drivers/login
  def login
    driver = Driver.find_by(email: params[:email])
    if driver&.authenticate(params[:password])
      render json: success_response(driver)
    else
      render json: format_errors(['Invalid email or password']), status: :unauthorized
    end
  end

  private

  def driver_params
    params.require(:driver).permit(:email, :password)
  end

  def format_errors(errors)
    { errors: Array(errors).map { |error| { detail: error } } }
  end

  def success_response(driver)
    {
      meta: { token: JwtService.encode(driver_id: driver.id) },
      data: DriverSerializer.new(driver).serializable_hash[:data]
    }
  end
end