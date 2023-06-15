# app/serializers/user_serializer.rb
class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :created_at, :updated_at
  has_many :reservations
  has_many :comments
  has_many :likes
end
