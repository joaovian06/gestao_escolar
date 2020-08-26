class Enrollment < ApplicationRecord
  belongs_to :student
  belongs_to :classroom

  validates :registration_num,
            :student,
            :classroom,
            presence: true

  validates :registration_num, uniqueness: true

  validates :student_id, uniqueness: { scoped: :classroom_id }

  validates_length_of :registration_num, minimum: 5
end


