class Professor < ApplicationRecord
  validates :name,
            :cellphone,
            presence: true

  validates :name, length: { minimum: 10 }
  validates_length_of :cellphone, is: 10
end
