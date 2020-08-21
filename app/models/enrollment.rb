class Enrollment < ApplicationRecord
  belongs_to :student
  belongs_to :classroom

  validates :registration_num,
            :student,
            :classroom,
            presence: true

  validates :registration_num, uniqueness: true

  validates_length_of :registration_num, minimum: 10
end
