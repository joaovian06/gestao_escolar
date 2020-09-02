class Classroom < ApplicationRecord
  has_many :enrollments, inverse_of: :classroom, dependent: :destroy
  accepts_nested_attributes_for :enrollments, allow_destroy: true

  enum school_period: %i[morning afternoon night]

  validates :name,
            :school_period,
            :year,
            presence: true

  validates_length_of :name, minimum: 6

  validates :name, uniqueness: { scope: :year }
end
