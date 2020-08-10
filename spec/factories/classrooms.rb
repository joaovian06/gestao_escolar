FactoryBot.define do
  factory :classroom do
    sequence(:name) { |n| "Turma #{n}" }
    school_period { 1 }
    year { 2020 }

    trait :invalid do
      year { 2019 }
    end
  end
end
