class Reservation < ApplicationRecord
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :description, presence: true

  belongs_to :user
  has_many :rooms, through: :reservations_rooms
end
