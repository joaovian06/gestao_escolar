FactoryBot.define do
  factory :student do
    name { Faker::Name.name }
    address { Faker::Address.street_address }
    email { Faker::Internet.email }
    birthday { Faker::Date.birthday(min_age: 6, max_age: 18) }
    gender { Student.genders.keys.sample }
    disability { false }
  end
end
