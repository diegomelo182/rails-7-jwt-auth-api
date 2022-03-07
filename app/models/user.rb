class User < ApplicationRecord
  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates :email, presence: true, length: { minimum: 10, maximum: 255 }
  validates :password, presence: true, length: { minimum: 6, maximum: 255 },
                       format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
end
