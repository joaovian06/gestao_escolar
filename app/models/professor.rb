class Professor < ApplicationRecord
  validates :name,
            :cellphone,
            presence: true

  validates :name, length: { minimum: 10 }

  validates_length_of :cellphone, is: 10

  validates_format_of :cellphone, with: /\d{5}-{1}\d{4}/
end
