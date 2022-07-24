include BCrypt
class Unit < ApplicationRecord
  has_secure_password
end
