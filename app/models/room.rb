class Room < ActiveRecord::Base
  has_many :comments
  # has_many :rooms, through: :room_reservations
end
