# frozen_string_literal: true

require 'jwt'

class JwtService
  SECRET_KEY = Rails.application.secret_key_base
  DEFAULT_EXPIRATION = ENV.fetch('JWT_EXPIRATION_HOURS', 24).to_i.hours

  class << self
    # Encode payload with expiration
    def encode(payload, exp = DEFAULT_EXPIRATION.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET_KEY, 'HS256')
    end

    # Decode token and return payload
    def decode(token)
      body = JWT.decode(token, SECRET_KEY, true, { algorithm: 'HS256' }).first
      HashWithIndifferentAccess.new(body)
    rescue JWT::ExpiredSignature
      Rails.logger.warn('JWT decode failed: Token has expired')
      nil
    rescue JWT::DecodeError
      Rails.logger.warn('JWT decode failed: Invalid token')
      nil
    end
  end
end