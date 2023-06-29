# app/models/reservation.rb
class Reservation < ApplicationRecord
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :description, presence: true

  belongs_to :user
  belongs_to :vespa
end
