

FactoryBot.define do
  factory :driver do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
