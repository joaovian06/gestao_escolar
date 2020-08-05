class Professor < ApplicationRecord
  validates :name, presence: true,
                  length: { minimum: 10 }

  validates :cellphone, presence: true
end
