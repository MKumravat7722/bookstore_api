class Book < ApplicationRecord
   belongs_to :author, class_name: "User"
   has_many :comments, dependent: :destroy

  validates :title, :content, presence: true
end
