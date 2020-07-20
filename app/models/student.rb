class Student < ApplicationRecord
  validates :name, presence: true,
                    length: { minimum: 10 }
  validates :address, presence: true
end
