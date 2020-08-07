FactoryBot.define do
  factory :professor do
    name { Faker::Name.name_with_middle }
    cellphone { '99999-9999' }
    trait :invalid do
      name { '' }
    end
  end
end
