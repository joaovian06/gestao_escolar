FactoryBot.define do
  factory :professor do
    name { Faker::Name.name }
    cellphone { Faker::PhoneNumber.cell_phone }
  end
end
