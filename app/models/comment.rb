# app/models/comment.rb
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :likes

  validates :content, presence: true
end
