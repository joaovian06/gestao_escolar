class Classroom < ApplicationRecord
  enum school_period: %i[morning afternoon night]

  validates :name,
            :school_period,
            :year,
            presence: true

  validates_length_of :name, minimum: 6

  validates :name, uniqueness: { scope: :year }
end
