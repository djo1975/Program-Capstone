class Room < ApplicationRecord
  has_many :comments

  has_many :reservations

  validates :name, presence: true
  validates :icon, presence: true
  validates :cost_per_day, presence: true
end
