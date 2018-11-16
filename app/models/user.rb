class User < ApplicationRecord
  belongs_to :messenger

  # validation
  validates_presence_of :name
end
