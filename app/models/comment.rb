class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :room
  has_many :likes
end
