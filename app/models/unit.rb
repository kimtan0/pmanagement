include BCrypt
class Unit < ApplicationRecord
  has_secure_password
  has_many :payment
  has_many :complaint
end
