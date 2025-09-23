class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :role
  has_many :books
  has_many :comments
end
