FactoryBot.define do
  factory :enrollment do
    sequence(:registration_num) { |n| "#{classroom.year}#{n}" }
    student
    classroom

    trait :invalid do
      student { nil }
    end
  end
end
