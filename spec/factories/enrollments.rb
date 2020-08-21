FactoryBot.define do
  factory :enrollment do
    sequence(:registration_num) { |n| "#{n}".rjust(11 - n.to_s.length, "0") }
    student
    classroom

    trait :invalid do
      student { nil }
    end
  end
end
