class User < ApplicationRecord
  has_secure_password
  belongs_to :messenger

  # validation
  validates_presence_of :name
end
