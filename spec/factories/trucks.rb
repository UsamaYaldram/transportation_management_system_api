

FactoryBot.define do
  factory :truck do
    name { Faker::Vehicle.manufacture }
    truck_type { 'jumbo_5000' }
  end
end