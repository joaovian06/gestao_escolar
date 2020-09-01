class Enrollment < ApplicationRecord
  before_validation :set_registration_num

  belongs_to :student, inverse_of: :enrollments
  belongs_to :classroom, inverse_of: :enrollments

  validates :student,
            :classroom,
            presence: true

  validates :student_id, uniqueness: { scope: :classroom_id }

  private

  def set_registration_num
    self.registration_num = Time.now.to_f.to_s
  end
end
