class Student < ApplicationRecord
  enum gender: [:male, :female]
  validates :name, presence: true,
                    length: { minimum: 10 }
  validates :address, presence: true
  validates :email, presence: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :birthday, presence: true
  validate :validate_today_birthday
  validates :gender, presence: true

  private

  def validate_today_birthday
    errors.add(:birthday, 'birthday cant be today') if birthday == Date.today
  end
end
