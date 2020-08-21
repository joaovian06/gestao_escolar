class Enrollment < ApplicationRecord
  belongs_to :student
  belongs_to :classroom

  validates :registration_num, presence: true

  validates :registration_num, uniqueness: true

  validates :student, presence: true

  validates :classroom, presence: true

  validates_length_of :registration_num, minimum: 10
end
