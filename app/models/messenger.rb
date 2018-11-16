class Messenger < ApplicationRecord
  # model association
  has_many :users, dependent: :destroy

  # validations
  validates_presence_of :name
end
