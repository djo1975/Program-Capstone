class Vespa < ApplicationRecord
  has_many :comments
  has_many :reservations

  def comments_count
    comments.count
  end

  validates :name, presence: true
  validates :icon, presence: true
  validates :cost_per_day, presence: true
end
