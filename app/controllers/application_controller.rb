# frozen_string_literal: true

class ApplicationController < ActionController::API
  def authenticate_driver
    token = request.headers['Authorization']&.split(' ')&.last
    return render json: { error: 'Unauthorized' }, status: :unauthorized unless token

    decoded = JwtService.decode(token)
    @current_driver = Driver.find_by(id: decoded[:driver_id]) if decoded
    render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_driver
  end

  def current_driver
    @current_driver
  end
end
