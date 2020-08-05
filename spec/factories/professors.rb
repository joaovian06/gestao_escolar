FactoryBot.define do
  factory :professor do
    name { Faker::Name.name }
    cellphone { '99999-9999' }
  end
end
