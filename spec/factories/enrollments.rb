FactoryBot.define do
  factory :enrollment do
    student
    classroom

    trait :invalid do
      student { nil }
    end
  end
end
