class Professor < ApplicationRecord
  validates :name, presence: true,
                  length: { minimum: 10 }
end
