FactoryBot.define do
  factory :classroom do
    sequence(:name) { |n| "Turma #{n}" }
    school_period { 1 }
  end
end
