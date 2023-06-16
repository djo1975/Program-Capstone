# app/models/comment.rb
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :likes, dependent: :destroy

  def likes_count
    likes.count
  end

  validates :content, presence: true
end
