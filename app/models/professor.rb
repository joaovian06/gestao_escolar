class Professor < ApplicationRecord
  validates :name,
            :cellphone,
            presence: true

  validates :name, length: { minimum: 10 }
end
