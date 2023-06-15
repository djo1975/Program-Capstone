class User < ApplicationRecord
  has_many :reservations
  has_many :comments
  has_many :likes

  validates :username, presence: true, uniqueness: true
end
