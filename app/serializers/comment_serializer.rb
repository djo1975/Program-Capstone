# app/serializers/comment_serializer.rb
class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :updated_at
  belongs_to :user
  belongs_to :room
  has_many :likes
end
