FactoryBot.define do
  factory :student do
    name { Faker::Name }
    address { Faker::Address.street_address }
    email { Faker::Internet.email }
    birthday { Faker::Date.in_date_period }
    gender { 1 }
    disability { false }
  end
end
