# frozen_string_literal: true

# classe model estudante
class Student < ApplicationRecord
  enum gender: %i[male female]

  validates :name,
            :address,
            :email,
            :birthday,
            :gender,
            presence: true

  validates :name, length: { minimum: 10 }

  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validate :validate_today_birthday

  private

  def validate_today_birthday
    errors.add(:birthday, 'birthday cant be today') if birthday == Date.today
  end
end
