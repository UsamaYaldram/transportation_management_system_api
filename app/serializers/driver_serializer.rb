# frozen_string_literal: true

class DriverSerializer
  include JSONAPI::Serializer

  set_type :driver
  attributes :email

  has_many :trucks
end
