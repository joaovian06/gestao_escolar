FactoryBot.define do
  factory :student do
    name { Faker::Name.name_with_middle }
    address { Faker::Address.street_address }
    email { Faker::Internet.email }
    birthday { Faker::Date.birthday(min_age: 6, max_age: 18) }
    gender { Student.genders.keys.sample }
    disability { false }
    trait :invalid do
      address { '' }
    end
  end
end
