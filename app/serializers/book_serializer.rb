class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :content, :published_at, :author_name
  has_many :comments
  def author_name
    object.author.name
  end
end
