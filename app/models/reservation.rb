class Reservation < ApplicationRecord

	validates :start_date, presence: true
  validates :end_date, presence: true
  validates :description, presence: true
end
