class Classroom < ApplicationRecord
  enum school_period: %i[morning afternoon night]

  validates :name,
            :school_period,
            :year,
            presence: true

  validates_length_of :name, minimum: 6

  validate :validate_actual_year

  validates_numericality_of :year, only_integer: true

  private

  def validate_actual_year
    errors.add(:year, "year can't be different from actual year") if year != Date.today.year
  end
end
